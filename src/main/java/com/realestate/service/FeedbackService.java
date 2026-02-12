package com.realestate.service;

import com.realestate.model.Feedback;
import com.realestate.model.User;
import com.realestate.util.Constants;
import com.realestate.util.FileManager;
import com.realestate.util.FileUtil;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

/**
 * Service class to handle operations related to user feedback
 */
public class FeedbackService {

    /**
     * Save a list of feedback to file
     * @param feedbackList The list of feedback to save
     * @return true if the operation was successful
     */
    public boolean saveFeedback(List<Feedback> feedbackList) {
        return FileUtil.writeObjectsToFile(feedbackList, FileUtil.getFilePath(Constants.FEEDBACK_FILE));
    }

    /**
     * Load all feedback from file
     * @return A list of all feedback
     */
    public List<Feedback> getAllFeedback() {
        return FileUtil.readObjectsFromFile(FileUtil.getFilePath(Constants.FEEDBACK_FILE), Feedback[].class);
    }

    /**
     * Add new feedback
     * @param feedback The feedback to add
     * @return true if the operation was successful
     */
    public boolean addFeedback(Feedback feedback) {
        // Set a unique ID for the feedback
        feedback.setId(generateFeedbackId());
        
        // Get existing feedback
        List<Feedback> feedbackList = getAllFeedback();
        
        // Add the new feedback
        feedbackList.add(feedback);
        
        // Save the updated list
        return saveFeedback(feedbackList);
    }

    /**
     * Update existing feedback
     * @param updatedFeedback The updated feedback
     * @return true if the operation was successful
     */
    public boolean updateFeedback(Feedback updatedFeedback) {
        List<Feedback> feedbackList = getAllFeedback();
        
        // Find the feedback to update
        for (int i = 0; i < feedbackList.size(); i++) {
            if (feedbackList.get(i).getId().equals(updatedFeedback.getId())) {
                // Update feedback while preserving the original user and date
                updatedFeedback.setUserId(feedbackList.get(i).getUserId());
                updatedFeedback.setUserName(feedbackList.get(i).getUserName());
                updatedFeedback.setUserType(feedbackList.get(i).getUserType());
                updatedFeedback.setDateTime(feedbackList.get(i).getDateTime());
                
                // Replace the old feedback with the updated one
                feedbackList.set(i, updatedFeedback);
                
                // Save the updated list
                return saveFeedback(feedbackList);
            }
        }
        
        return false; // Feedback not found
    }

    /**
     * Delete feedback by ID
     * @param id The ID of the feedback to delete
     * @return true if the operation was successful
     */
    public boolean deleteFeedback(String id) {
        List<Feedback> feedbackList = getAllFeedback();
        
        // Find and remove the feedback
        boolean removed = feedbackList.removeIf(feedback -> feedback.getId().equals(id));
        
        if (removed) {
            // Save the updated list
            return saveFeedback(feedbackList);
        }
        
        return false; // Feedback not found
    }

    /**
     * Get feedback by ID
     * @param id The ID of the feedback to retrieve
     * @return The feedback with the specified ID, or null if not found
     */
    public Feedback getFeedbackById(String id) {
        Optional<Feedback> feedback = getAllFeedback().stream()
                .filter(f -> f.getId().equals(id))
                .findFirst();
        
        return feedback.orElse(null);
    }

    /**
     * Get all feedback by user ID
     * @param userId The ID of the user
     * @return A list of feedback by the specified user
     */
    public List<Feedback> getFeedbackByUserId(String userId) {
        return getAllFeedback().stream()
                .filter(feedback -> feedback.getUserId().equals(userId))
                .collect(Collectors.toList());
    }

    /**
     * Check if a user can edit/delete specific feedback
     * @param user The user
     * @param feedbackId The ID of the feedback
     * @return true if the user is allowed to edit/delete the feedback
     */
    public boolean canUserModifyFeedback(User user, String feedbackId) {
        Feedback feedback = getFeedbackById(feedbackId);
        
        if (feedback == null || user == null) {
            return false;
        }
        
        // Check if the user is the owner of the feedback
        boolean isOwner = user.getId().equals(feedback.getUserId());
        
        // Check if the user is an admin
        boolean isAdmin = false;
        try {
            isAdmin = (boolean) user.getClass().getMethod("isAdmin").invoke(user);
        } catch (Exception e) {
            // Not an admin
        }
        
        // User can modify if they are the owner or an admin
        return isOwner || isAdmin;
    }

    /**
     * Generate a unique ID for a new feedback
     * @return A unique feedback ID
     */
    private String generateFeedbackId() {
        List<Feedback> feedbackList = getAllFeedback();
        int maxId = 0;
        
        for (Feedback feedback : feedbackList) {
            String id = feedback.getId();
            if (id.startsWith("F") && id.length() > 1) {
                try {
                    int idNum = Integer.parseInt(id.substring(1));
                    if (idNum > maxId) {
                        maxId = idNum;
                    }
                } catch (NumberFormatException e) {
                    // Ignore invalid IDs
                }
            }
        }
        
        return "F" + (maxId + 1);
    }
} 