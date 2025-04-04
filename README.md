# Bank Application Overview

This is a Flutter-based bank application that integrates Supabase for backend services, offering a secure platform to manage bank-related transactions, cards, expenses, and income. The application includes authentication via Google, and allows users to perform CRUD operations related to bank cards and track expenses in various categories.

---

### Key Features:

1. **User Authentication and Authorization**:  
   The app allows users to log in via Google Authentication. Once logged in, users can interact with their bank-related data securely.
   ![e9418322-7ebe-4644-83e4-4170daeae7bb](https://github.com/user-attachments/assets/64726324-12f9-47f2-b2fe-0a35af572143)
   ![a155bd1b-e00a-4d9f-8725-14a474868d83](https://github.com/user-attachments/assets/f44e4a37-fb78-4644-a3cb-c99487a09252)

2. **Bank Cards Management**:  
   Users can manage multiple bank cards, including information such as:
   - Transaction number
   - Expiration date
   - Balance
   - Bank details (connected via `bankNameProvider`)

   Each card is tied to a specific user, and CRUD operations are available for adding, updating, and removing cards.

3. **Transactions**:  
   The app tracks transactions associated with each bank card. Users can add transactions that involve income and expenses, each linked to specific cards.
   ![b8c47a3b-3669-40bf-8ee6-08570437ac26](https://github.com/user-attachments/assets/b2f0a886-fada-4fd5-bde8-938ab35a160f)

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
   ![image](https://github.com/user-attachments/assets/72089ea8-171d-4f9f-9731-0a3361321d20)
   ![image](https://github.com/user-attachments/assets/da2c4b39-65d8-4f7a-a867-df87fdd846e1)

8. **Mapbox Integration for Bank Locations**:  
   The application integrates Mapbox to show the locations of banks on an interactive map. With Mapbox, the app retrieves and displays the locations of various bank branches, helping users find nearby banks and related services. The map allows users to zoom in and out to explore bank locations based on their current position or specified area.

   - **Mapbox Setup**: The app uses the Mapbox SDK to render maps, and it retrieves locations for each bank stored in the database. The map markers show where the bank branches are located, and users can interact with these markers for more information about each bank.
   - **Real-time Location Updates**: The map updates in real-time, showing the nearest bank locations based on the user's geolocation. Users can easily find bank branches around them by enabling location services on their devices.

![5c6fe17c-d782-481b-9acd-fdc7d71722cc](https://github.com/user-attachments/assets/be58bc93-2d10-40dc-a654-33da85fedda1)

---
