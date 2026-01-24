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
    String userId = request.getParameter("userId");
    String userName = request.getParameter("userName");
    String userType = request.getParameter("userType");
    String title = request.getParameter("title");
    String content = request.getParameter("content");
    String ratingStr = request.getParameter("rating");
    
    // Validate parameters
    if (userId == null || userName == null || userType == null || title == null || 
        content == null || ratingStr == null || title.trim().isEmpty() || content.trim().isEmpty()) {
        response.sendRedirect("add-feedback.jsp?error=Missing required fields");
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
    
    // Verify userId matches the logged-in user or is admin
    boolean isAdmin = false;
    try {
        isAdmin = (boolean) user.getClass().getMethod("isAdmin").invoke(user);
    } catch (Exception e) {
        // Not an admin
    }
    
    if (!userId.equals(user.getId()) && !isAdmin) {
        response.sendRedirect("display-feedback.jsp?error=Invalid user data");
        return;
    }
    
    try {
        // Create a new feedback object
        Feedback feedback = new Feedback();
        feedback.setUserId(userId);
        feedback.setUserName(userName);
        feedback.setUserType(userType);
        feedback.setTitle(title);
        feedback.setContent(content);
        feedback.setRating(rating);
        
        // Save the feedback
        FeedbackService feedbackService = new FeedbackService();
        boolean success = feedbackService.addFeedback(feedback);
        
        if (success) {
            response.sendRedirect("display-feedback.jsp?message=Feedback submitted successfully");
        } else {
            response.sendRedirect("add-feedback.jsp?error=Failed to save feedback");
        }
    } catch (Exception e) {
        response.sendRedirect("add-feedback.jsp?error=" + e.getMessage());
    }
%> 