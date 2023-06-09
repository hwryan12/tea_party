# Tea Subscription Service
![istockphoto-696205894-612x612](https://github.com/hwryan12/tea_party/assets/116698937/86eab267-68ab-4f51-b7d3-39292556464e)
## Introduction
This repository hosts a Tea Subscription Service, a backend Rails API project that was given as a take-home challenge. It provides a platform to manage customers, their tea subscriptions, and features various endpoints for interaction.

---
## Table of Contents
- [Introduction](#introduction)
- [Table of Contents](#table-of-contents)
- [About](#about)
- [Tech Stack](#tech-stack)
- [Getting Started](#getting-started)
- [Database Design](#database-design)
- [RESTful Endpoints](#restful-endpoints)
---

## About
The Tea Subscription Service is designed to provide a seamless and hassle-free experience to tea enthusiasts who wish to subscribe to their favourite tea offerings. Users can easily subscribe or cancel their subscriptions, and view all their active and cancelled subscriptions at any point. To maintain a scalable and easily consumable API, the service is built with RESTful conventions and Object-Oriented Programming principles.

## Tech Stack
- **Ruby on Rails:** The framework used for implementing the server-side logic and RESTful API endpoints.
- **PostgreSQL:** The database system used for data persistence.
- **RSpec:** The testing framework used for developing the application using Test-Driven Development (TDD) principles.
- **jsonapi-serializer:** Used for serializing the API data to JSON:API format, providing a clear and organized structure of the data.
- **Postman:** Used for manual testing of the API endpoints.

## Getting Started
1. **Clone the Repository:** Get started by cloning the repository to your local machine.
3. **Install Dependencies:** Navigate into the cloned repository and install necessary dependencies.
    
    ```bundle install```
5. **Start the Server:** Fire up the localhost server.
    
    ```rails server```
    
    Note: Please ensure you have Ruby and Rails installed on your machine before running these commands.
---
## Database Design
<details>
<summary> Schema </summary>
<br>

![Screenshot 2023-06-08 at 7 01 41 AM](https://github.com/hwryan12/tea_party/assets/116698937/da90c416-c003-4d29-83bd-58a498447a4d)

</details>


The design of this application's database is structured around four primary tables: `customers`, `subscriptions`, `teas`, and the `subscription_teas` join table. 

1. **Customers**: The `customers` table stores information related to our users, including first and last name, email, and address.

2. **Subscriptions**: The `subscriptions` table represents the different subscriptions available. It contains details like title, price, status (active or cancelled), and frequency. It also includes a `customer_id` foreign key to denote the customer to whom each subscription belongs.

3. **Teas**: The `teas` table holds information about the different types of tea available, such as title, description, brewing temperature, and brew time.

4. **Subscription_Teas**: The `subscription_teas` table is a join table that connects `subscriptions` and `teas` in a many-to-many relationship. Each row in this table represents a specific tea included in a particular subscription.

In the current design, there is a one-to-many relationship from `customers` to `subscriptions`, meaning one customer can have multiple subscriptions, but each subscription is associated with only one customer. This was a conscious design decision based on the requirements of the project. 

However, it's worth noting that depending on business needs, this design could be revised to a many-to-many relationship between `customers` and `subscriptions`. This adjustment could allow a `subscription` to be shared among multiple `customers`. For instance, a family or a group of friends might want to subscribe to the same tea subscription service, each with their own customer account, to track their individual preferences and consumption, but not to pay multiple times for essentially the same subscription being sent to the same address. With the current design, this scenario isn't possible without creating a duplicate `subscription` for each `customer`. A many-to-many relationship could be established with an additional join table, such as `customer_subscriptions`, which would contain `customer_id` and `subscription_id` to handle shared `subscriptions`. These decisions would be based on a thorough understanding of the business model and user requirements, and would need careful handling of the business logic, such as payments, to ensure that shared subscriptions are billed correctly and only once.

## RESTful Endpoints

Base url to reach the endpoints listed below:
```
http://localhost:3000/api/v1
```

<details close>
<summary> All Endpoints </summary>

### Create a new subscription

```http
POST /customers/:id/subscriptions
```

<details close>
<summary>  Details </summary>
<br>

Request: <br>
```json
{
    "subscription": {
        "title": "Monthly Tea Subscription",
        "price": 15.99,
        "status": "active",
        "frequency": "monthly",
        "customer_id": 1,
        "tea_ids": [1]
    }
}
```

| Code | Description |
| :--- | :--- |
| 201 | `Created` |

Response:

```json

{
    "data": {
        "id": "4",
        "type": "subscription",
        "attributes": {
            "id": 4,
            "title": "Monthly Tea Subscription",
            "price": "15.99",
            "status": "active",
            "frequency": "monthly",
            "customer_id": 1,
            "tea_ids": [
                1
            ]
        }
    }
}
```

| Code | Description |
| :--- | :--- |
| 404 | `NOT FOUND` |

Response:

```json

{
    "error": [
        "title": "NOT FOUND",
        "status": "404"
    ]
}
```

</details>

---

### Cancel a subscription

```http
PUT /customers/:id/subscriptions/:id
```

<details close>
<summary>  Details </summary>
<br>

Request: <br>
```json
{
    "subscription": {
        "status": "cancelled"
    }
}
```

| Code | Description |
| :--- | :--- |
| 204 | `OK` |

Response:

```json
{
    "data": {
        "id": "1",
        "type": "subscription",
        "attributes": {
            "id": 1,
            "title": "Monthly Tea Subscription",
            "price": "15.99",
            "status": "cancelled",
            "frequency": "monthly",
            "customer_id": 1,
            "tea_ids": [
                1,
                2
            ]
        }
    }
}
```

| Code | Description |
| :--- | :--- |
| 404 | `NOT FOUND` |

Response:

```json

{
    "error": [
        "title": "NOT FOUND",
        "status": "404"
    ]
}
```

</details>

---

### Get all of a customer's subscriptions(active or cancelled)

```http
GET /customers/:id/subscriptions
```

<details close>
<summary>  Details </summary>
<br>

Request: <br>
```json
  "customer_id": 1
```

| Code | Description |
| :--- | :--- |
| 200 | `OK` |

Response:

```json
{
    "data": [
        {
            "id": "1",
            "type": "subscription",
            "attributes": {
                "id": 1,
                "title": "Monthly Tea Subscription",
                "price": "15.99",
                "status": "cancelled",
                "frequency": "monthly",
                "customer_id": 1,
                "tea_ids": [
                    1,
                    2
                ]
            }
        },
        {
            "id": "2",
            "type": "subscription",
            "attributes": {
                "id": 2,
                "title": "Monthly Tea Subscription",
                "price": "15.99",
                "status": "cancelled",
                "frequency": "monthly",
                "customer_id": 1,
                "tea_ids": [
                    1,
                    2
                ]
            }
        }, (etc.)
    ]
}
```

</details>

--- 

</details>
</details>
