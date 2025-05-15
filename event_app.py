import cx_Oracle

# Connect to Oracle DB
conn = cx_Oracle.connect("username/password@localhost/orcl")
cursor = conn.cursor()


def insert_user():
    user_id = int(input("Enter UserID: "))
    name = input("Enter name: ")
    email = input("Enter email: ")
    password = input("Enter password: ")
    role = input("Enter role (User/Admin): ")

    try:
        cursor.execute("""
            INSERT INTO Users (UserID, Name, Email, Password, Role)
            VALUES (:1, :2, :3, :4, :5)
        """, (user_id, name, email, password, role))
        conn.commit()
        print("User inserted successfully.\n")
    except cx_Oracle.IntegrityError as e:
        print("Error inserting user:", e)


def list_users():
    cursor.execute("SELECT * FROM Users")
    for row in cursor.fetchall():
        print(row)


def insert_ticket():
    ticket_id = int(input("Enter TicketID: "))
    event_id = int(input("Enter EventID: "))
    user_id = int(input("Enter UserID: "))
    seat = input("Enter Seat No: ")
    ticket_type = input("Enter Ticket Type: ")
    price = float(input("Enter Price: "))
    status = input("Enter Status (Booked/Cancelled): ")

    try:
        cursor.execute("""
            INSERT INTO Tickets (TicketID, EventID, UserID, SeatNo, TicketType, Price, Status)
            VALUES (:1, :2, :3, :4, :5, :6, :7)
        """, (ticket_id, event_id, user_id, seat, ticket_type, price, status))
        conn.commit()
        print("Ticket inserted successfully.\n")
    except cx_Oracle.IntegrityError as e:
        print("Error inserting ticket:", e)


def main():
    while True:
        print("\nEvent Ticket System")
        print("1. Add User")
        print("2. List Users")
        print("3. Book Ticket")
        print("4. Exit")

        choice = input("Enter your choice: ")
        if choice == '1':
            insert_user()
        elif choice == '2':
            list_users()
        elif choice == '3':
            insert_ticket()
        elif choice == '4':
            break
        else:
            print("Invalid option!")

    cursor.close()
    conn.close()


if __name__ == "__main__":
    main()
