<%@ page import="com.realestate.model.User" %>
<%@ page import="com.realestate.util.Constants" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Check if user is logged in
    User user = (User) session.getAttribute(Constants.SESSION_USER);
    boolean isLoggedIn = user != null;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us - Real Estate</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
    <link rel="stylesheet" href="css/style.css">
    <style>
        .hero-contact {
            background: linear-gradient(rgba(26, 115, 232, 0.8), rgba(13, 71, 161, 0.9)), 
                        url('https://images.unsplash.com/photo-1560520031-3a4dc4e9de0c?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80');
            background-size: cover;
            background-position: center;
            height: 400px;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            color: white;
            position: relative;
        }
        
        .contact-container {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 50px;
            margin: 60px 0;
        }
        
        .contact-form {
            background-color: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
        }
        
        .contact-form h2 {
            color: var(--primary-dark);
            margin-bottom: 20px;
            font-size: 1.8rem;
            position: relative;
            padding-bottom: 15px;
        }
        
        .contact-form h2::after {
            content: '';
            position: absolute;
            left: 0;
            bottom: 0;
            width: 60px;
            height: 3px;
            background-color: var(--primary-color);
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
        
        .form-group input,
        .form-group textarea,
        .form-group select {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid var(--border-color);
            border-radius: 4px;
            font-size: 16px;
            transition: border-color 0.3s;
        }
        
        .form-group input:focus,
        .form-group textarea:focus,
        .form-group select:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 2px rgba(26, 115, 232, 0.2);
        }
        
        .form-group textarea {
            resize: vertical;
            min-height: 150px;
        }
        
        .submit-btn {
            background-color: var(--primary-color);
            color: white;
            border: none;
            border-radius: 4px;
            padding: 12px 25px;
            font-size: 16px;
            font-weight: 500;
            cursor: pointer;
            transition: background-color 0.3s;
            width: 100%;
        }
        
        .submit-btn:hover {
            background-color: var(--primary-dark);
        }
        
        .contact-info {
            background-color: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
        }
        
        .contact-info h2 {
            color: var(--primary-dark);
            margin-bottom: 20px;
            font-size: 1.8rem;
            position: relative;
            padding-bottom: 15px;
        }
        
        .contact-info h2::after {
            content: '';
            position: absolute;
            left: 0;
            bottom: 0;
            width: 60px;
            height: 3px;
            background-color: var(--primary-color);
        }
        
        .info-item {
            display: flex;
            align-items: flex-start;
            margin-bottom: 25px;
        }
        
        .info-icon {
            width: 50px;
            height: 50px;
            background-color: var(--primary-light);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            font-size: 20px;
            color: var(--primary-color);
        }
        
        .info-content h4 {
            margin: 0;
            color: var(--primary-dark);
            font-size: 1.1rem;
            margin-bottom: 5px;
        }
        
        .info-content p, 
        .info-content a {
            margin: 0;
            color: var(--text-light);
            text-decoration: none;
        }
        
        .info-content a:hover {
            color: var(--primary-color);
        }
        
        .social-links {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }
        
        .social-link {
            width: 40px;
            height: 40px;
            background-color: var(--primary-light);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--primary-color);
            text-decoration: none;
            transition: all 0.3s;
        }
        
        .social-link:hover {
            background-color: var(--primary-color);
            color: white;
            transform: translateY(-3px);
        }
        
        .business-hours {
            background-color: var(--primary-light);
            padding: 20px;
            border-radius: 8px;
            margin-top: 30px;
        }
        
        .business-hours h4 {
            color: var(--primary-dark);
            margin-bottom: 15px;
            font-size: 1.2rem;
        }
        
        .hours-item {
            display: flex;
            justify-content: space-between;
            padding: 8px 0;
            border-bottom: 1px dashed rgba(26, 115, 232, 0.2);
        }
        
        .hours-item:last-child {
            border-bottom: none;
        }
        
        .day {
            font-weight: 500;
            color: var(--text-color);
        }
        
        .time {
            color: var(--primary-dark);
        }
        
        .map-container {
            margin-top: 60px;
            height: 500px;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
        }
        
        .map-container iframe {
            width: 100%;
            height: 100%;
            border: 0;
        }
        
        .faq-section {
            margin: 60px 0;
            background-color: var(--secondary-color);
            padding: 60px 0;
        }
        
        .faq-container {
            max-width: 800px;
            margin: 0 auto;
        }
        
        .faq-item {
            background-color: white;
            border-radius: 8px;
            margin-bottom: 20px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
            overflow: hidden;
        }
        
        .faq-question {
            padding: 20px;
            cursor: pointer;
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-weight: 500;
            color: var(--primary-dark);
        }
        
        .faq-question::after {
            content: '+';
            font-size: 1.5rem;
        }
        
        .faq-item.active .faq-question::after {
            content: '−';
        }
        
        .faq-answer {
            max-height: 0;
            overflow: hidden;
            transition: max-height 0.3s ease;
        }
        
        .faq-item.active .faq-answer {
            max-height: 500px;
        }
        
        .faq-answer-content {
            padding: 0 20px 20px;
            color: var(--text-light);
            line-height: 1.6;
        }
        
        @media (max-width: 992px) {
            .contact-container {
                grid-template-columns: 1fr;
            }
        }
        
        @media (max-width: 768px) {
            .hero-contact {
                height: 300px;
            }
            
            .map-container {
                height: 350px;
            }
        }
    </style>
</head>
<body>
    <header>
        <div class="container">
            <nav class="navbar">
                <a href="index.jsp" class="logo">Real Estate</a>
                
                <ul class="nav-links">
                    <li><a href="index.jsp">Home</a></li>
                    <li><a href="property-details.jsp">Properties</a></li>
                    <li><a href="about.jsp">About</a></li>
                    <li><a href="contact.jsp">Contact</a></li>
                </ul>
                
                <div class="user-actions">
                    <% if (!isLoggedIn) { %>
                        <a href="login.jsp" class="btn btn-outline">Login</a>
                        <a href="register.jsp" class="btn btn-primary">Register</a>
                    <% } else { %>
                        <a href="dashboard.jsp" class="btn btn-outline">Dashboard</a>
                        <a href="logout" class="btn btn-primary">Logout</a>
                    <% } %>
                </div>
                
                <button class="menu-toggle">
                    <i class="fa fa-bars"></i>
                </button>
            </nav>
        </div>
    </header>
    
    <main>
        <!-- Hero Section -->
        <section class="hero-contact">
            <div class="container">
                <div class="hero-content">
                    <h1>Get in Touch</h1>
                    <p>We're here to answer any questions you may have about our properties or services</p>
                </div>
            </div>
        </section>
        
        <!-- Contact Content -->
        <section class="container">
            <div class="contact-container">
                <!-- Contact Form -->
                <div class="contact-form">
                    <h2>Send Us a Message</h2>
                    <form action="submit-contact.jsp" method="post">
                        <div class="form-group">
                            <label for="name">Full Name</label>
                            <input type="text" id="name" name="name" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="email">Email Address</label>
                            <input type="email" id="email" name="email" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="phone">Phone Number</label>
                            <input type="tel" id="phone" name="phone">
                        </div>
                        
                        <div class="form-group">
                            <label for="subject">Subject</label>
                            <select id="subject" name="subject" required>
                                <option value="">Select a subject</option>
                                <option value="general">General Inquiry</option>
                                <option value="property">Property Information</option>
                                <option value="viewing">Schedule a Viewing</option>
                                <option value="support">Technical Support</option>
                                <option value="feedback">Feedback</option>
                            </select>
                        </div>
                        
                        <div class="form-group">
                            <label for="message">Your Message</label>
                            <textarea id="message" name="message" required></textarea>
                        </div>
                        
                        <button type="submit" class="submit-btn">Send Message</button>
                    </form>
                </div>
                
                <!-- Contact Information -->
                <div class="contact-info">
                    <h2>Contact Information</h2>
                    
                    <div class="info-item">
                        <div class="info-icon">
                            <i class="fas fa-map-marker-alt"></i>
                        </div>
                        <div class="info-content">
                            <h4>Our Location</h4>
                            <p>123 Real Estate Avenue, Suite 450<br>New York, NY 10001</p>
                        </div>
                    </div>
                    
                    <div class="info-item">
                        <div class="info-icon">
                            <i class="fas fa-phone-alt"></i>
                        </div>
                        <div class="info-content">
                            <h4>Phone Number</h4>
                            <p><a href="tel:+12125551234">(212) 555-1234</a></p>
                            <p><a href="tel:+18005551000">1-800-555-1000</a> (Toll-free)</p>
                        </div>
                    </div>
                    
                    <div class="info-item">
                        <div class="info-icon">
                            <i class="fas fa-envelope"></i>
                        </div>
                        <div class="info-content">
                            <h4>Email Address</h4>
                            <p><a href="mailto:info@realestate.com">info@realestate.com</a></p>
                            <p><a href="mailto:support@realestate.com">support@realestate.com</a></p>
                        </div>
                    </div>
                    
                    <div class="business-hours">
                        <h4>Business Hours</h4>
                        <div class="hours-item">
                            <span class="day">Monday - Friday</span>
                            <span class="time">9:00 AM - 6:00 PM</span>
                        </div>
                        <div class="hours-item">
                            <span class="day">Saturday</span>
                            <span class="time">10:00 AM - 4:00 PM</span>
                        </div>
                        <div class="hours-item">
                            <span class="day">Sunday</span>
                            <span class="time">Closed</span>
                        </div>
                    </div>
                    
                    <div class="social-links">
                        <a href="#" class="social-link"><i class="fab fa-facebook-f"></i></a>
                        <a href="#" class="social-link"><i class="fab fa-twitter"></i></a>
                        <a href="#" class="social-link"><i class="fab fa-instagram"></i></a>
                        <a href="#" class="social-link"><i class="fab fa-linkedin-in"></i></a>
                        <a href="#" class="social-link"><i class="fab fa-youtube"></i></a>
                    </div>
                </div>
            </div>
            
            <!-- Map Section -->
            <div class="map-container">
                <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3022.215172901206!2d-73.99800742387195!3d40.75085383440442!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x89c259a9b30eac9f%3A0x4170c5893a96e5fa!2sEmpire%20State%20Building!5e0!3m2!1sen!2sus!4v1685971186887!5m2!1sen!2sus" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
            </div>
        </section>
        
        <!-- FAQ Section -->
        <section class="faq-section">
            <div class="container">
                <h2 class="section-title">Frequently Asked Questions</h2>
                <p class="section-subtitle">Find answers to common questions about our services</p>
                
                <div class="faq-container">
                    <div class="faq-item">
                        <div class="faq-question">How do I schedule a property viewing?</div>
                        <div class="faq-answer">
                            <div class="faq-answer-content">
                                You can schedule a property viewing by contacting us through the form above, calling our office during business hours, or using the "Schedule Viewing" button on any property listing page. One of our agents will get back to you within 24 hours to confirm your appointment.
                            </div>
                        </div>
                    </div>
                    
                    <div class="faq-item">
                        <div class="faq-question">What documents do I need when applying for a property?</div>
                        <div class="faq-answer">
                            <div class="faq-answer-content">
                                When applying for a property, you'll typically need proof of identity (government-issued ID), proof of income (pay stubs, tax returns, or bank statements), employment verification, rental history references, and sometimes a credit check authorization. Specific requirements may vary depending on the property.
                            </div>
                        </div>
                    </div>
                    
                    <div class="faq-item">
                        <div class="faq-question">How long does the application process take?</div>
                        <div class="faq-answer">
                            <div class="faq-answer-content">
                                Our standard application processing time is 2-3 business days once we've received all required documentation. However, this may vary depending on the volume of applications and the responsiveness of references and previous landlords.
                            </div>
                        </div>
                    </div>
                    
                    <div class="faq-item">
                        <div class="faq-question">Can I list my property on your website?</div>
                        <div class="faq-answer">
                            <div class="faq-answer-content">
                                Yes, we offer property listing services for homeowners and property investors. You can register an account as a seller/landlord and follow the listing steps. Our team reviews all listings before they go public to ensure quality and accuracy.
                            </div>
                        </div>
                    </div>
                    
                    <div class="faq-item">
                        <div class="faq-question">What areas do you serve?</div>
                        <div class="faq-answer">
                            <div class="faq-answer-content">
                                We currently serve the greater New York metropolitan area, including Manhattan, Brooklyn, Queens, The Bronx, Staten Island, and nearby parts of New Jersey and Connecticut. We're continuously expanding our service area to meet client demands.
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </main>
    
    <footer>
        <div class="container">
            <div class="footer-content">
                <div class="footer-section">
                    <h3>Real Estate</h3>
                    <p>Finding you the perfect property is our passion. With years of experience and market knowledge, we're here to make your real estate journey smooth and successful.</p>
                </div>
                
                <div class="footer-section">
                    <h3>Quick Links</h3>
                    <ul>
                        <li><a href="index.jsp">Home</a></li>
                        <li><a href="property-details.jsp">Properties</a></li>
                        <li><a href="about.jsp">About</a></li>
                        <li><a href="contact.jsp">Contact</a></li>
                    </ul>
                </div>
                
                <div class="footer-section">
                    <h3>Contact</h3>
                    <ul>
                        <li><i class="fa fa-map-marker-alt"></i> 123 Real Estate Ave, New York</li>
                        <li><i class="fa fa-phone"></i> (212) 555-1234</li>
                        <li><i class="fa fa-envelope"></i> info@realestate.com</li>
                    </ul>
                </div>
            </div>
            
            <div class="footer-bottom">
                <p>&copy; 2023 Real Estate Management System. All rights reserved.</p>
            </div>
        </div>
    </footer>
    
    <script>
        // Mobile menu toggle
        document.querySelector('.menu-toggle').addEventListener('click', function() {
            document.querySelector('.nav-links').classList.toggle('active');
        });
        
        // FAQ accordion functionality
        document.querySelectorAll('.faq-question').forEach(question => {
            question.addEventListener('click', () => {
                const faqItem = question.parentElement;
                faqItem.classList.toggle('active');
                
                // Close other open FAQ items
                document.querySelectorAll('.faq-item').forEach(item => {
                    if (item !== faqItem) {
                        item.classList.remove('active');
                    }
                });
            });
        });
    </script>
</body>
</html> 