<%@ page import="com.realestate.model.User" %>
<%@ page import="com.realestate.model.Feedback" %>
<%@ page import="com.realestate.util.Constants" %>
<%@ page import="com.realestate.service.FeedbackService" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Check if user is logged in
    User user = (User) session.getAttribute(Constants.SESSION_USER);
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Check user roles
    boolean isAdmin = false;
    try {
        isAdmin = (boolean) user.getClass().getMethod("isAdmin").invoke(user);
    } catch (Exception e) {
        // Not an admin
    }
    
    // Load all feedback
    FeedbackService feedbackService = new FeedbackService();
    List<Feedback> feedbackList = feedbackService.getAllFeedback();
    
    // Get success or error messages if any
    String message = request.getParameter("message");
    String error = request.getParameter("error");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Feedback - Real Estate</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="css/style.css">
    <style>
        .feedback-container {
            margin-bottom: 40px;
        }
        
        .feedback-card {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            padding: 20px;
            margin-bottom: 20px;
            position: relative;
            transition: transform 0.3s ease;
        }
        
        .feedback-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        
        .feedback-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
            border-bottom: 1px solid #eee;
            padding-bottom: 10px;
        }
        
        .feedback-title {
            font-size: 1.2rem;
            color: var(--primary-dark);
            margin: 0;
        }
        
        .feedback-content {
            color: var(--text-color);
            line-height: 1.6;
            margin-bottom: 15px;
        }
        
        .feedback-meta {
            display: flex;
            justify-content: space-between;
            color: #777;
            font-size: 0.9rem;
            margin-top: 20px;
        }
        
        .feedback-actions {
            margin-top: 15px;
            text-align: right;
        }
        
        .feedback-actions a {
            margin-left: 10px;
            text-decoration: none;
            color: var(--primary-color);
        }
        
        .feedback-actions a:hover {
            text-decoration: underline;
        }
        
        .rating {
            display: inline-block;
            color: #ffc107;
            font-size: 1.2rem;
            margin-left: 10px;
        }
        
        .empty-state {
            text-align: center;
            padding: 40px 20px;
            background-color: #f9f9f9;
            border-radius: 8px;
        }
        
        .empty-state i {
            font-size: 3rem;
            color: #ccc;
            margin-bottom: 15px;
        }
        
        .btn-add-feedback {
            display: block;
            width: max-content;
            margin: 20px auto;
        }
        
        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 4px;
        }
        
        .alert-success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        
        .alert-danger {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        
        /* Badge styles */
        .badge {
            padding: 4px 8px;
            border-radius: 30px;
            font-size: 12px;
            font-weight: 500;
            margin-right: 5px;
        }
        
        .badge-seller {
            background-color: #e3f2fd;
            color: #1976d2;
        }
        
        .badge-buyer {
            background-color: #e8f5e9;
            color: #388e3c;
        }
        
        .badge-admin {
            background-color: #fff3e0;
            color: #e65100;
        }
        
        .badge-own {
            background-color: #f3e5f5;
            color: #7b1fa2;
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header>
        <div class="container">
            <nav class="navbar">
                <a href="<%= request.getContextPath() %>/index.jsp" class="logo">Real Estate</a>
                <ul class="nav-links">
                    <li><a href="<%= request.getContextPath() %>/index.jsp">Home</a></li>
                    <li><a href="<%= request.getContextPath() %>/properties">Properties</a></li>
                    <li><a href="<%= request.getContextPath() %>/about.jsp">About</a></li>
                    <li><a href="<%= request.getContextPath() %>/contact.jsp">Contact</a></li>
                </ul>
                
                <div class="user-actions">
                    <a href="<%= request.getContextPath() %>/dashboard.jsp" class="btn btn-outline">Dashboard</a>
                    <a href="<%= request.getContextPath() %>/logout" class="btn btn-primary">Logout</a>
                </div>
                
                <button class="menu-toggle">
                    <i class="fa fa-bars"></i>
                </button>
            </nav>
        </div>
    </header>
    
    <!-- Main Content -->
    <main>
        <section>
            <div class="container">
                <h2 class="section-title">Website Feedback</h2>
                
                <% if (message != null && !message.isEmpty()) { %>
                <div class="alert alert-success">
                    <%= message %>
                </div>
                <% } %>
                
                <% if (error != null && !error.isEmpty()) { %>
                <div class="alert alert-danger">
                    <%= error %>
                </div>
                <% } %>
                
                <div class="feedback-container">
                    <a href="<%= request.getContextPath() %>/add-feedback.jsp" class="btn btn-primary btn-add-feedback">
                        <i class="fa fa-plus"></i> Add New Feedback
                    </a>
                    
                    <% if (feedbackList.isEmpty()) { %>
                    <div class="empty-state">
                        <i class="fa fa-comments-o"></i>
                        <h3>No Feedback Yet</h3>
                        <p>Be the first to share your experience with our website!</p>
                        <a href="<%= request.getContextPath() %>/add-feedback.jsp" class="btn btn-primary">
                            Add Feedback
                        </a>
                    </div>
                    <% } else { %>
                        <% for (Feedback feedback : feedbackList) { 
                            boolean isOwner = user.getId().equals(feedback.getUserId());
                        %>
                        <div class="feedback-card">
                            <div class="feedback-header">
                                <h3 class="feedback-title"><%= feedback.getTitle() %></h3>
                                <div class="rating">
                                    <% for (int i = 0; i < feedback.getRating(); i++) { %>
                                    <i class="fa fa-star"></i>
                                    <% } %>
                                    <% for (int i = feedback.getRating(); i < 5; i++) { %>
                                    <i class="fa fa-star-o"></i>
                                    <% } %>
                                </div>
                            </div>
                            
                            <div class="feedback-content">
                                <%= feedback.getContent() %>
                            </div>
                            
                            <div class="feedback-meta">
                                <div>
                                    <span class="badge badge-<%= feedback.getUserType().toLowerCase() %>">
                                        <%= feedback.getUserType() %>
                                    </span>
                                    <% if (isOwner) { %>
                                    <span class="badge badge-own">Your feedback</span>
                                    <% } %>
                                    <span><%= feedback.getUserName() %></span>
                                </div>
                                <div><%= feedback.getDateTime() %></div>
                            </div>
                            
                            <% if (isOwner || isAdmin) { %>
                            <div class="feedback-actions">
                                <a href="<%= request.getContextPath() %>/edit-feedback.jsp?id=<%= feedback.getId() %>">
                                    <i class="fa fa-pencil"></i> Edit
                                </a>
                                <a href="<%= request.getContextPath() %>/delete-feedback.jsp?id=<%= feedback.getId() %>" 
                                   onclick="return confirm('Are you sure you want to delete this feedback?');">
                                    <i class="fa fa-trash"></i> Delete
                                </a>
                            </div>
                            <% } %>
                        </div>
                        <% } %>
                    <% } %>
                </div>
            </div>
        </section>
    </main>
    
    <!-- Footer -->
    <footer>
        <div class="container">
            <div class="footer-content">
                <div class="footer-section">
                    <h3>Real Estate</h3>
                    <p>Your trusted partner in finding the perfect property.</p>
                </div>
                
                <div class="footer-section">
                    <h3>Quick Links</h3>
                    <ul>
                        <li><a href="<%= request.getContextPath() %>/index.jsp">Home</a></li>
                        <li><a href="<%= request.getContextPath() %>/properties">Properties</a></li>
                        <li><a href="<%= request.getContextPath() %>/about.jsp">About Us</a></li>
                        <li><a href="<%= request.getContextPath() %>/contact.jsp">Contact Us</a></li>
                    </ul>
                </div>
                
                <div class="footer-section">
                    <h3>Contact Us</h3>
                    <ul>
                        <li><i class="fa fa-map-marker"></i> 123 Main St, City</li>
                        <li><i class="fa fa-phone"></i> (123) 456-7890</li>
                        <li><i class="fa fa-envelope"></i> info@realestate.com</li>
                    </ul>
                </div>
            </div>
            
            <div class="footer-bottom">
                <p>&copy; 2023 Real Estate Management System. All rights reserved.</p>
            </div>
        </div>
    </footer>
    
    <script src="js/main.js"></script>
</body>
</html> 