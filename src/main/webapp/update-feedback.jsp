<%@ page import="com.realestate.model.User" %>
<%@ page import="com.realestate.model.Feedback" %>
<%@ page import="com.realestate.service.FeedbackService" %>
<%@ page import="com.realestate.util.Constants" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Check if user is logged in
    User user = (User) session.getAttribute(Constants.SESSION_USER);
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    // Get form parameters
    String feedbackId = request.getParameter("id");
    String title = request.getParameter("title");
    String content = request.getParameter("content");
    String ratingStr = request.getParameter("rating");
    
    // Validate parameters
    if (feedbackId == null || title == null || content == null || 
        ratingStr == null || title.trim().isEmpty() || content.trim().isEmpty()) {
        response.sendRedirect("display-feedback.jsp?error=Missing required fields");
        return;
    }
    
    // Parse rating
    int rating = 5; // Default to 5 stars if parsing fails
    try {
        rating = Integer.parseInt(ratingStr);
        if (rating < 1 || rating > 5) {
            rating = 5; // Ensure rating is between 1-5
        }
    } catch (NumberFormatException e) {
        // Use default
    }
    
    // Get the feedback service
    FeedbackService feedbackService = new FeedbackService();
    
    // Check if user can modify this feedback
    if (!feedbackService.canUserModifyFeedback(user, feedbackId)) {
        response.sendRedirect("display-feedback.jsp?error=You do not have permission to edit this feedback");
        return;
    }
    
    try {
        // Get the existing feedback
        Feedback feedback = feedbackService.getFeedbackById(feedbackId);
        if (feedback == null) {
            response.sendRedirect("display-feedback.jsp?error=Feedback not found");
            return;
        }
        
        // Update the feedback
        feedback.setTitle(title);
        feedback.setContent(content);
        feedback.setRating(rating);
        
        // Save the updated feedback
        boolean success = feedbackService.updateFeedback(feedback);
        
        if (success) {
            response.sendRedirect("display-feedback.jsp?message=Feedback updated successfully");
        } else {
            response.sendRedirect("edit-feedback.jsp?id=" + feedbackId + "&error=Failed to update feedback");
        }
    } catch (Exception e) {
        response.sendRedirect("edit-feedback.jsp?id=" + feedbackId + "&error=" + e.getMessage());
    }
%> 