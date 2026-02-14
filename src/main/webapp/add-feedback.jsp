<%@ page import="com.realestate.model.User" %>
<%@ page import="com.realestate.util.Constants" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Check if user is logged in
    User user = (User) session.getAttribute(Constants.SESSION_USER);
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    // Determine user type
    String userType = "";
    if (user.getClass().getSimpleName().equals("Seller")) {
        userType = Constants.ROLE_SELLER;
    } else if (user.getClass().getSimpleName().equals("Buyer")) {
        userType = Constants.ROLE_BUYER;
    } else if (user.getClass().getSimpleName().equals("Admin")) {
        userType = Constants.ROLE_ADMIN;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Feedback - Real Estate</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="css/style.css">
    <style>
        .form-container {
            max-width: 700px;
            margin: 0 auto 40px;
            background-color: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: var(--text-color);
        }
        
        .form-control {
            width: 100%;
            padding: 10px 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
            transition: border-color 0.3s;
        }
        
        .form-control:focus {
            border-color: var(--primary-color);
            outline: none;
        }
        
        textarea.form-control {
            min-height: 150px;
            resize: vertical;
        }
        
        .star-rating {
            display: flex;
            flex-direction: row-reverse;
            justify-content: flex-end;
        }
        
        .star-rating input {
            display: none;
        }
        
        .star-rating label {
            cursor: pointer;
            font-size: 30px;
            color: #ccc;
            margin-right: 5px;
        }
        
        .star-rating label:before {
            content: '★';
        }
        
        .star-rating input:checked ~ label {
            color: #ffc107;
        }
        
        .star-rating label:hover,
        .star-rating label:hover ~ label {
            color: #ffdb70;
        }
        
        .btn-container {
            display: flex;
            justify-content: space-between;
            margin-top: 30px;
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
                <h2 class="section-title">Add Your Feedback</h2>
                
                <div class="form-container">
                    <form action="<%= request.getContextPath() %>/submit-feedback.jsp" method="post">
                        <input type="hidden" name="userId" value="<%= user.getId() %>">
                        <input type="hidden" name="userName" value="<%= user.getFirstName() + " " + user.getLastName() %>">
                        <input type="hidden" name="userType" value="<%= userType %>">
                        
                        <div class="form-group">
                            <label for="title">Title</label>
                            <input type="text" id="title" name="title" class="form-control" required
                                   placeholder="Give your feedback a descriptive title">
                        </div>
                        
                        <div class="form-group">
                            <label for="content">Feedback Content</label>
                            <textarea id="content" name="content" class="form-control" required
                                      placeholder="Describe your experience with our website..."></textarea>
                        </div>
                        
                        <div class="form-group">
                            <label>Rating</label>
                            <div class="star-rating">
                                <input type="radio" id="star5" name="rating" value="5" required>
                                <label for="star5" title="5 stars"></label>
                                
                                <input type="radio" id="star4" name="rating" value="4">
                                <label for="star4" title="4 stars"></label>
                                
                                <input type="radio" id="star3" name="rating" value="3">
                                <label for="star3" title="3 stars"></label>
                                
                                <input type="radio" id="star2" name="rating" value="2">
                                <label for="star2" title="2 stars"></label>
                                
                                <input type="radio" id="star1" name="rating" value="1">
                                <label for="star1" title="1 star"></label>
                            </div>
                        </div>
                        
                        <div class="btn-container">
                            <a href="<%= request.getContextPath() %>/display-feedback.jsp" class="btn btn-outline">
                                Cancel
                            </a>
                            <button type="submit" class="btn btn-primary">
                                Submit Feedback
                            </button>
                        </div>
                    </form>
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