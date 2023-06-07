# Tea Party APIs
## Introduction
This repository hosts a Tea Subscription Service, a backend Rails API project that was given as a take-home challenge. It provides a platform to manage customers, their tea subscriptions, and features various endpoints for interaction.

---
## Table of Contents
- [Introduction](#introduction)
- [Table of Contents](#table-of-contents)
- [About](#about)
- [Tech Stack](#tech-stack)
- [Getting Started](#getting-started)
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
---
## Getting Started
1. **Clone the Repository:** Get started by cloning the repository to your local machine.
2. **Install Dependencies:** Navigate into the cloned repository and install necessary dependencies.
3. **Start the Server:** Fire up the localhost server.
Note: Please ensure you have Ruby and Rails installed on your machine before running these commands.

---
## RESTful Endpoints

Base url to reach the endpoints listed below:
```
http://localhost:3000/api/v1
```

<details close>
<summary> All Endpoints </summary>

### Create a new subscription

```http
POST /subscriptions
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
PUT /subscriptions/:id
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
