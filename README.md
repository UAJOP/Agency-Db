# 🏢 Agency-DB (Ajans Personel ve İş Takip Veri Tabanı)

**Agency-DB** is a **database management system** designed for an **organization agency** to track its personnel, clients, projects, and expenses. This project was developed based on real-world requirements gathered from an actual agency owner.

## 🛠 Technologies Used
- **SQL (Structured Query Language)** – Core database development.
- **MySQL / MSSQL** – Database management system.
- **Chen Notation (E-R Diagram)** – Database schema design.
- **Stored Procedures & Triggers** – Automated operations.
- **Normalization & Foreign Keys** – Optimized relational structure.

## 📌 Features
- 👥 **Personnel Management** – Track employees by department, city, and assigned jobs.
- 💼 **Job & Project Tracking** – Monitor agency work, associated employees, and earnings.
- 🏢 **Client Database** – Store customer details and contract history.
- 💰 **Salary Management** – Different salary structures for each department.
- 📄 **Expense Management** – Record expenses using categorized invoice types.
- 🔄 **Database Procedures & Triggers** – Automate data handling.

## 📊 Database Structure
The database consists of multiple interlinked tables:
- **Personnel Table** – Stores employee details (linked via `city_id` and `dept_id` foreign keys).
- **Departments Table** – Defines available job roles and salaries.
- **Cities Table** – Stores location details for personnel.
- **Clients Table** – Holds customer data for event management.
- **Jobs Table** – Tracks agency jobs, linked with personnel and client records.
- **Expenses Table** – Monitors costs associated with each project.
- **Invoices Table** – Categorizes expense types and transactions.

## 📥 Installation & Setup
To set up this project locally:

1. **Clone the repository:**
   `git clone https://github.com/UAJOP/Agency-Db.git`
   
2. Open **MySQL/MSSQL Server Management Studio**.

3. Run the provided **SQL scripts** to create tables and relationships.

4. Populate initial data using **INSERT statements**.

5. Execute stored procedures to test database automation.

## 📌 How It Works
1. **Agency assigns personnel** to events based on client requirements.
2. **Jobs are recorded** in the database, linking employees and customers.
3. **Expense tracking** is maintained via categorized invoices.
4. **Salary calculation** is automated through department-based pay scales.
5. **Stored procedures and triggers** ensure data consistency.

## 🔧 Future Improvements
- Implementing a **web-based UI** for easier interaction.
- Adding **automated reporting** for financial insights.
- Enhancing **real-time notifications** for personnel assignments.

## 🤝 Contributions
Contributions are welcome! If you have suggestions or find any issues, feel free to **submit a pull request** or open an **issue**.

## 📩 Contact
For any inquiries or support, feel free to reach out:

- 🌍 **Website:** [kaan-balci.com](https://kaan-balci.com)
- 🔗 **LinkedIn:** [linkedin.com/in/balcikaan](https://www.linkedin.com/in/balcikaan/)
- 📧 **Email:** [kaanb8776@gmail.com](mailto:kaanb8776@gmail.com)

---

💡 *A structured and efficient database system designed for agency personnel and job management!*
