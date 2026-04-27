# 🏠 Real Estate Property Listing Web Application

A Java Servlet & JSP based web application for managing real estate listings — no database required.

---

## 📌 Overview

Users can register as **buyers or sellers**, browse and manage property listings, save favourites, and submit feedback. Admins can manage users and properties. Data is stored in plain text files.

---

## ✨ Features

- User registration, login, and logout (Buyer / Seller / Admin roles)
- Browse, add, edit, and delete property listings
- View property details and save favourites/cart
- Submit, edit, and delete feedback
- Admin: manage users and properties
- File-based storage (no database needed)
- Responsive UI with CSS and JavaScript

---

## 🛠️ Tech Stack

| Layer | Technology |
|---|---|
| Backend | Java Servlets |
| Frontend | JSP, HTML, CSS, JavaScript |
| Storage | Text files |
| Build Tool | Maven |
| Server | Apache Tomcat 9 |
| JSON | Gson |
| IDE | IntelliJ IDEA |
| Packaging | WAR |

---

## ✅ Prerequisites

- **Java JDK 22**
- **Maven**
- **Apache Tomcat 9** (required — project uses `javax.servlet`)
- **IntelliJ IDEA** (Ultimate recommended)

---

## 🚀 Setup & Run

```bash
# 1. Clone the repository
git clone https://github.com/Himaka12/RealEstateProperty.git
cd RealEstateProperty

# 2. Build the project
mvn clean package
```

Then in **IntelliJ IDEA**:

1. Open the project folder
2. Reload Maven dependencies (right-click `pom.xml` → Maven → Reload Project)
3. Go to **Run → Edit Configurations → + → Tomcat Server → Local**
4. Under **Deployment**, add the WAR exploded artifact
5. Set the context path to `/realestate`
6. Click **Run**

Open in browser: `http://localhost:8080/realestate`

> **No database setup needed.** The app reads/writes data from text files (`users.txt`, `Property.txt`, `Feedback.txt`, etc.).

---

## 📁 Key Project Structure

```
RealEstateProperty/
├── src/main/
│   ├── java/com/realestate/
│   │   ├── model/        # User, Buyer, Seller, Admin, Property, Feedback
│   │   ├── service/      # UserService, PropertyService, FeedbackService
│   │   ├── servlet/      # LoginServlet, RegisterServlet, PropertyServlet, etc.
│   │   └── util/         # FileManager, FileUtil, Constants, PropertyBST
│   └── webapp/
│       ├── WEB-INF/web.xml
│       ├── css/ & js/
│       └── *.jsp         # All UI pages
├── pom.xml
└── README.md
```

---

## ⚠️ Common Issues

| Problem | Fix |
|---|---|
| Maven dependencies missing | Right-click `pom.xml` → Maven → Reload Project |
| Tomcat not starting | Check port 8080 is free; verify Tomcat version and SDK |
| Page not found | Use correct URL: `http://localhost:8080/realestate` |
| Data not saving | Ensure the app has write permissions to its data directory |
| Java version error | Run `java -version`; set SDK to Java 22 in File → Project Structure |

---

## 🔐 Security Note

This project is intended for **learning and academic use**. For production, add password hashing, input validation, session security, and role-based access control.

---

## 👨‍💻 Author

**Himaka Uthpala** — [GitHub](https://github.com/Himaka12)
