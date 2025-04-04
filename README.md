# Bank Application Overview

This is a Flutter-based bank application that integrates Supabase for backend services, offering a secure platform to manage bank-related transactions, cards, expenses, and income. The application includes authentication via Google, and allows users to perform CRUD operations related to bank cards and track expenses in various categories.

---

### Key Features:

1. **User Authentication and Authorization**:  
   The app allows users to log in via Google Authentication. Once logged in, users can interact with their bank-related data securely.

2. **Bank Cards Management**:  
   Users can manage multiple bank cards, including information such as:
   - Transaction number
   - Expiration date
   - Balance
   - Bank details (connected via `bankNameProvider`)

   Each card is tied to a specific user, and CRUD operations are available for adding, updating, and removing cards.

3. **Transactions**:  
   The app tracks transactions associated with each bank card. Users can add transactions that involve income and expenses, each linked to specific cards.

4. **Expense Categories**:  
   Expenses are classified into different categories, such as food, gas, Netflix, clothing, etc. Categories are associated with transactions to help users track where they are spending their money.

5. **Income Tracking**:  
   Users can log income transactions with details such as the amount and the date of the income. Income transactions can be linked to specific cards.

6. **State Management**:  
   The application utilizes Flutter's provider package for state management. Several providers are used to handle the app's data flow, including:
   - `UserProvider`: Manages user data.
   - `CardProvider`: Handles CRUD operations related to bank cards.
   - `ExpensesProvider`: Handles user expenses.
   - `IncomeProvider`: Manages income-related transactions.
   - `TransactionsProvider`: Handles transaction operations.
   - `ExpensesCategoryProvider`: Manages expense categories (food, gas, etc.).

7. **Database Integration with Supabase**:  
   The app is integrated with Supabase, providing secure backend functionality for:
   - Storing user data
   - Managing transactions, income, and expenses
   - Handling bank card information
   - Real-time syncing of data between the app and Supabase
   - Authentication via Supabase's built-in authentication system

8. **Mapbox Integration for Bank Locations**:  
   The application integrates Mapbox to show the locations of banks on an interactive map. With Mapbox, the app retrieves and displays the locations of various bank branches, helping users find nearby banks and related services. The map allows users to zoom in and out to explore bank locations based on their current position or specified area.

   - **Mapbox Setup**: The app uses the Mapbox SDK to render maps, and it retrieves locations for each bank stored in the database. The map markers show where the bank branches are located, and users can interact with these markers for more information about each bank.
   - **Real-time Location Updates**: The map updates in real-time, showing the nearest bank locations based on the user's geolocation. Users can easily find bank branches around them by enabling location services on their devices.

---

### Screenshots:

1. **User Authentication and Authorization**  
   <img src="https://github.com/user-attachments/assets/600b0369-99db-4c40-83c6-11f26617473d" width="300"/>
   <img src="https://github.com/user-attachments/assets/ff98b413-d9a5-4068-87a6-2c5354bcc237" width="300"/>

2. **Bank Cards Management**  
   <img src="https://github.com/user-attachments/assets/cd673a87-7353-42ac-9f53-48aaf551bd8a" width="300"/>

3. **Transactions**  
   <img src="https://github.com/user-attachments/assets/43f3f6a6-dad5-4fed-bf56-dc08e5a46ba8" width="300"/>

4. **Expense Categories**  
   <img src="https://github.com/user-attachments/assets/b6a88fa7-6a82-4489-9979-aacb8b31cda3" width="300"/>


5. **Database Integration with Supabase**  
   <img src="https://github.com/user-attachments/assets/72089ea8-171d-4f9f-9731-0a3361321d20" width="500"/>
   <img src="https://github.com/user-attachments/assets/da2c4b39-65d8-4f7a-a867-df87fdd846e1" width="500"/>

6. **Mapbox Integration for Bank Locations**  
   <img src="https://github.com/user-attachments/assets/43c0b9ad-ef8a-45d7-8ab9-90a4c1193ac9" width="300"/>
