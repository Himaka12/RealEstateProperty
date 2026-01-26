<%@ page import="com.realestate.model.User" %>
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
    
    // Get feedback ID parameter
    String feedbackId = request.getParameter("id");
    if (feedbackId == null || feedbackId.isEmpty()) {
        response.sendRedirect("display-feedback.jsp?error=No feedback ID provided");
        return;
    }
    
    // Get the feedback service
    FeedbackService feedbackService = new FeedbackService();
    
    // Check if user can modify this feedback
    if (!feedbackService.canUserModifyFeedback(user, feedbackId)) {
        response.sendRedirect("display-feedback.jsp?error=You do not have permission to delete this feedback");
        return;
    }
    
    try {
        // Delete the feedback
        boolean success = feedbackService.deleteFeedback(feedbackId);
        
        if (success) {
            response.sendRedirect("display-feedback.jsp?message=Feedback deleted successfully");
        } else {
            response.sendRedirect("display-feedback.jsp?error=Failed to delete feedback");
        }
    } catch (Exception e) {
        response.sendRedirect("display-feedback.jsp?error=" + e.getMessage());
    }
%> 