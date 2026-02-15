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
    <title>About Us - Real Estate</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="css/style.css">
    <style>
        .hero-about {
            background: linear-gradient(rgba(26, 115, 232, 0.8), rgba(13, 71, 161, 0.9)), 
                        url('https://images.unsplash.com/photo-1560518883-ce09059eeffa?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80');
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
        
        .hero-content {
            z-index: 2;
            max-width: 800px;
        }
        
        .about-section {
            background-color: white;
            padding: 60px 0;
            margin-bottom: 0;
        }
        
        .about-section:nth-child(even) {
            background-color: var(--secondary-color);
        }
        
        .about-container {
            display: flex;
            flex-wrap: wrap;
            align-items: center;
            gap: 40px;
        }
        
        .about-image {
            flex: 1;
            min-width: 300px;
        }
        
        .about-image img {
            width: 100%;
            border-radius: 8px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        
        .about-content {
            flex: 1;
            min-width: 300px;
        }
        
        .about-content h2 {
            color: var(--primary-dark);
            margin-bottom: 20px;
            font-size: 2rem;
            position: relative;
            padding-bottom: 15px;
        }
        
        .about-content h2::after {
            content: '';
            position: absolute;
            left: 0;
            bottom: 0;
            width: 60px;
            height: 3px;
            background-color: var(--primary-color);
        }
        
        .about-content p {
            margin-bottom: 20px;
            color: var(--text-light);
            line-height: 1.8;
        }
        
        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 30px;
            margin: 50px 0;
        }
        
        .stat-box {
            text-align: center;
            padding: 30px 20px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            transition: transform 0.3s ease;
        }
        
        .stat-box:hover {
            transform: translateY(-10px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
        }
        
        .stat-number {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--primary-color);
            margin-bottom: 10px;
        }
        
        .stat-label {
            font-size: 1rem;
            color: var(--text-light);
        }
        
        .team-section {
            text-align: center;
            padding: 60px 0;
        }
        
        .team-heading {
            margin-bottom: 50px;
        }
        
        .team-heading h2 {
            font-size: 2rem;
            color: var(--primary-dark);
            margin-bottom: 15px;
        }
        
        .team-heading p {
            color: var(--text-light);
            max-width: 700px;
            margin: 0 auto;
        }
        
        .team-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 30px;
        }
        
        .team-member {
            background-color: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            transition: transform 0.3s ease;
        }
        
        .team-member:hover {
            transform: translateY(-10px);
        }
        
        .member-image {
            height: 250px;
            overflow: hidden;
        }
        
        .member-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s ease;
        }
        
        .team-member:hover .member-image img {
            transform: scale(1.1);
        }
        
        .member-info {
            padding: 20px;
            text-align: center;
        }
        
        .member-info h3 {
            margin: 0;
            font-size: 1.2rem;
            color: var(--primary-dark);
        }
        
        .member-role {
            color: var(--primary-color);
            margin: 5px 0 10px;
            font-weight: 500;
        }
        
        .member-bio {
            color: var(--text-light);
            font-size: 0.9rem;
            margin-bottom: 15px;
        }
        
        .social-links {
            display: flex;
            justify-content: center;
            gap: 15px;
        }
        
        .social-links a {
            width: 36px;
            height: 36px;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: var(--primary-light);
            color: var(--primary-color);
            border-radius: 50%;
            transition: all 0.3s ease;
        }
        
        .social-links a:hover {
            background-color: var(--primary-color);
            color: white;
        }
        
        .values-section {
            background-color: var(--secondary-color);
            padding: 60px 0;
        }
        
        .values-heading {
            text-align: center;
            margin-bottom: 50px;
        }
        
        .values-heading h2 {
            font-size: 2rem;
            color: var(--primary-dark);
            margin-bottom: 15px;
        }
        
        .values-heading p {
            color: var(--text-light);
            max-width: 700px;
            margin: 0 auto;
        }
        
        .values-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 30px;
        }
        
        .value-card {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            text-align: center;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            transition: transform 0.3s ease;
        }
        
        .value-card:hover {
            transform: translateY(-10px);
        }
        
        .value-icon {
            width: 70px;
            height: 70px;
            background-color: var(--primary-light);
            color: var(--primary-color);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.8rem;
            margin: 0 auto 20px;
        }
        
        .value-card h3 {
            font-size: 1.2rem;
            color: var(--primary-dark);
            margin-bottom: 15px;
        }
        
        .value-card p {
            color: var(--text-light);
            line-height: 1.6;
        }
        
        .testimonials-section {
            padding: 60px 0;
            text-align: center;
        }
        
        .testimonials-heading {
            margin-bottom: 50px;
        }
        
        .testimonials-heading h2 {
            font-size: 2rem;
            color: var(--primary-dark);
            margin-bottom: 15px;
        }
        
        .testimonials-heading p {
            color: var(--text-light);
            max-width: 700px;
            margin: 0 auto;
        }
        
        .testimonial {
            max-width: 800px;
            margin: 0 auto 40px;
            background-color: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            position: relative;
        }
        
        .testimonial-quote {
            font-size: 1.1rem;
            font-style: italic;
            color: var(--text-color);
            line-height: 1.8;
            margin-bottom: 20px;
            position: relative;
        }
        
        .testimonial-quote::before,
        .testimonial-quote::after {
            content: '"';
            font-size: 2.5rem;
            color: var(--primary-light);
            line-height: 0;
            position: absolute;
        }
        
        .testimonial-quote::before {
            left: -20px;
            top: 15px;
        }
        
        .testimonial-quote::after {
            right: -20px;
            bottom: -10px;
        }
        
        .client {
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .client-image {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            overflow: hidden;
            margin-right: 15px;
        }
        
        .client-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        
        .client-info {
            text-align: left;
        }
        
        .client-name {
            font-weight: 700;
            color: var(--primary-dark);
            margin-bottom: 5px;
        }
        
        .client-title {
            color: var(--primary-color);
            font-size: 0.9rem;
        }
        
        .cta-section {
            background: linear-gradient(rgba(26, 115, 232, 0.9), rgba(13, 71, 161, 0.9)), 
                        url('https://images.unsplash.com/photo-1558036117-15d82a90b9b1?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80');
            background-size: cover;
            background-position: center;
            padding: 80px 0;
            color: white;
            text-align: center;
        }
        
        .cta-content {
            max-width: 700px;
            margin: 0 auto;
        }
        
        .cta-content h2 {
            font-size: 2rem;
            margin-bottom: 20px;
        }
        
        .cta-content p {
            margin-bottom: 30px;
            font-size: 1.1rem;
        }
        
        .cta-buttons {
            display: flex;
            justify-content: center;
            gap: 20px;
            flex-wrap: wrap;
        }
        
        .btn-white {
            background-color: white;
            color: var(--primary-color);
            border: none;
        }
        
        .btn-white:hover {
            background-color: #f5f5f5;
        }
        
        .btn-outline-white {
            background-color: transparent;
            color: white;
            border: 2px solid white;
        }
        
        .btn-outline-white:hover {
            background-color: rgba(255, 255, 255, 0.1);
        }
        
        @media (max-width: 768px) {
            .hero-about {
                height: 300px;
            }
            
            .about-container {
                flex-direction: column;
            }
            
            .cta-buttons {
                flex-direction: column;
                align-items: center;
            }
            
            .team-grid, 
            .values-grid {
                grid-template-columns: 1fr;
                max-width: 400px;
                margin: 0 auto;
            }
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
                    <li><a href="<%= request.getContextPath() %>/about.jsp" class="active">About</a></li>
                    <li><a href="<%= request.getContextPath() %>/contact.jsp">Contact</a></li>
                </ul>
                
                <div class="user-actions">
                    <% if (isLoggedIn) { %>
                        <a href="<%= request.getContextPath() %>/dashboard.jsp" class="btn btn-outline">Dashboard</a>
                        <a href="<%= request.getContextPath() %>/logout" class="btn btn-primary">Logout</a>
                    <% } else { %>
                        <a href="<%= request.getContextPath() %>/login.jsp" class="btn btn-outline">Login</a>
                        <a href="<%= request.getContextPath() %>/register.jsp" class="btn btn-primary">Register</a>
                    <% } %>
                </div>
                
                <button class="menu-toggle">
                    <i class="fa fa-bars"></i>
                </button>
            </nav>
        </div>
    </header>
    
    <!-- Main Content -->
    <main>
        <section class="hero-about">
            <div class="hero-content">
                <h1>About Us</h1>
                <p>Discover the team and values behind our commitment to finding your perfect home</p>
            </div>
        </section>
        
        <section class="about-section">
            <div class="container">
                <div class="about-container">
                    <div class="about-image">
                        <img src="https://images.unsplash.com/photo-1600880292203-757bb62b4baf?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80" alt="Real Estate Office">
                    </div>
                    <div class="about-content">
                        <h2>Our Story</h2>
                        <p>Founded in 2008, our real estate agency began as a small family business with a passion for connecting people with their perfect homes. What started as a local operation has grown into one of the most trusted names in the industry, serving clients across the region.</p>
                        <p>Our journey has been defined by our unwavering commitment to excellence, integrity, and client satisfaction. We believe that finding a home is not just about property, but about helping people build their future and create lasting memories.</p>
                        <p>Today, we combine years of industry expertise with cutting-edge technology to provide an unparalleled real estate experience for buyers, sellers, and investors alike.</p>
                    </div>
                </div>
            </div>
        </section>
        
        <section class="about-section">
            <div class="container">
                <div class="stats-container">
                    <div class="stat-box">
                        <div class="stat-number">15+</div>
                        <div class="stat-label">Years of Experience</div>
                    </div>
                    <div class="stat-box">
                        <div class="stat-number">2,500+</div>
                        <div class="stat-label">Happy Clients</div>
                    </div>
                    <div class="stat-box">
                        <div class="stat-number">$1.2B</div>
                        <div class="stat-label">Properties Sold</div>
                    </div>
                    <div class="stat-box">
                        <div class="stat-number">98%</div>
                        <div class="stat-label">Client Satisfaction</div>
                    </div>
                </div>
            </div>
        </section>
        
        <section class="team-section">
            <div class="container">
                <div class="team-heading">
                    <h2>Meet Our Team</h2>
                    <p>Our success comes from our dedicated team of real estate professionals who bring expertise, integrity, and personalized service to every transaction.</p>
                </div>
                
                <div class="team-grid">
                    <div class="team-member">
                        <div class="member-image">
                            <img src="https://images.unsplash.com/photo-1560250097-0b93528c311a?ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80" alt="John Doe">
                        </div>
                        <div class="member-info">
                            <h3>John Doe</h3>
                            <div class="member-role">Founder & CEO</div>
                            <p class="member-bio">15+ years of experience in real estate market with a passion for helping families find their dream homes.</p>
                            <div class="social-links">
                                <a href="#"><i class="fa fa-linkedin"></i></a>
                                <a href="#"><i class="fa fa-twitter"></i></a>
                                <a href="#"><i class="fa fa-envelope"></i></a>
                            </div>
                        </div>
                    </div>
                    
                    <div class="team-member">
                        <div class="member-image">
                            <img src="https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80" alt="Jane Smith">
                        </div>
                        <div class="member-info">
                            <h3>Jane Smith</h3>
                            <div class="member-role">Senior Agent</div>
                            <p class="member-bio">12+ years specializing in residential properties with a keen eye for market trends and client needs.</p>
                            <div class="social-links">
                                <a href="#"><i class="fa fa-linkedin"></i></a>
                                <a href="#"><i class="fa fa-twitter"></i></a>
                                <a href="#"><i class="fa fa-envelope"></i></a>
                            </div>
                        </div>
                    </div>
                    
                    <div class="team-member">
                        <div class="member-image">
                            <img src="https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80" alt="Michael Johnson">
                        </div>
                        <div class="member-info">
                            <h3>Michael Johnson</h3>
                            <div class="member-role">Property Specialist</div>
                            <p class="member-bio">8+ years experience with expertise in investment properties and market analysis.</p>
                            <div class="social-links">
                                <a href="#"><i class="fa fa-linkedin"></i></a>
                                <a href="#"><i class="fa fa-twitter"></i></a>
                                <a href="#"><i class="fa fa-envelope"></i></a>
                            </div>
                        </div>
                    </div>
                    
                    <div class="team-member">
                        <div class="member-image">
                            <img src="https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80" alt="Sarah Williams">
                        </div>
                        <div class="member-info">
                            <h3>Sarah Williams</h3>
                            <div class="member-role">Client Relations</div>
                            <p class="member-bio">10+ years dedicated to ensuring exceptional client experience throughout the buying process.</p>
                            <div class="social-links">
                                <a href="#"><i class="fa fa-linkedin"></i></a>
                                <a href="#"><i class="fa fa-twitter"></i></a>
                                <a href="#"><i class="fa fa-envelope"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        
        <section class="values-section">
            <div class="container">
                <div class="values-heading">
                    <h2>Our Core Values</h2>
                    <p>These principles guide everything we do and shape our approach to real estate.</p>
                </div>
                
                <div class="values-grid">
                    <div class="value-card">
                        <div class="value-icon">
                            <i class="fa fa-handshake-o"></i>
                        </div>
                        <h3>Integrity</h3>
                        <p>We believe in honest, transparent communication and always putting our clients' needs first in every transaction.</p>
                    </div>
                    
                    <div class="value-card">
                        <div class="value-icon">
                            <i class="fa fa-line-chart"></i>
                        </div>
                        <h3>Expertise</h3>
                        <p>Our team stays at the forefront of market trends and real estate knowledge to provide informed guidance.</p>
                    </div>
                    
                    <div class="value-card">
                        <div class="value-icon">
                            <i class="fa fa-users"></i>
                        </div>
                        <h3>Community</h3>
                        <p>We're proud to be part of the neighborhoods we serve and actively give back through various initiatives.</p>
                    </div>
                    
                    <div class="value-card">
                        <div class="value-icon">
                            <i class="fa fa-lightbulb-o"></i>
                        </div>
                        <h3>Innovation</h3>
                        <p>We leverage the latest technology and creative solutions to make your real estate journey seamless and successful.</p>
                    </div>
                </div>
            </div>
        </section>
        
        <section class="testimonials-section">
            <div class="container">
                <div class="testimonials-heading">
                    <h2>What Our Clients Say</h2>
                    <p>Don't just take our word for it - hear from some of our satisfied clients.</p>
                </div>
                
                <div class="testimonial">
                    <p class="testimonial-quote">Working with this team made finding our dream home a breeze. Their attention to detail and understanding of our needs exceeded our expectations. We couldn't be happier with our new home!</p>
                    <div class="client">
                        <div class="client-image">
                            <img src="https://images.unsplash.com/photo-1531123897727-8f129e1688ce?ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80" alt="Client">
                        </div>
                        <div class="client-info">
                            <div class="client-name">Emily Robinson</div>
                            <div class="client-title">Homeowner</div>
                        </div>
                    </div>
                </div>
                
                <div class="testimonial">
                    <p class="testimonial-quote">As a first-time seller, I was nervous about the process. This team guided me through every step, got me a great price, and made the entire experience smooth and stress-free.</p>
                    <div class="client">
                        <div class="client-image">
                            <img src="https://images.unsplash.com/photo-1500648767791-00dcc994a43e?ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80" alt="Client">
                        </div>
                        <div class="client-info">
                            <div class="client-name">Robert Chen</div>
                            <div class="client-title">Property Seller</div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        
        <section class="cta-section">
            <div class="container">
                <div class="cta-content">
                    <h2>Ready to Find Your Dream Home?</h2>
                    <p>Let our experienced team guide you through the journey of finding the perfect property that meets all your needs.</p>
                    <div class="cta-buttons">
                        <a href="<%= request.getContextPath() %>/properties" class="btn btn-white">Browse Properties</a>
                        <a href="<%= request.getContextPath() %>/contact.jsp" class="btn btn-outline-white">Contact Us</a>
                    </div>
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