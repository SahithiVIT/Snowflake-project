CREATE OR REPLACE TABLE CREDIT_CARD_TRANSACTIONS ( 
transaction_id INT, 
customer_id INT, 
transaction_date DATE, 
amount FLOAT, 
merchant STRING, 
payment_type STRING
);
INSERT INTO CREDIT_CARD_TRANSACTIONS VALUES 
(1, 101, '2025-09-01', 500.00, 'Amazon', 'Online'), 
(2, 101, '2025-09-05', 1200.00, 'Flipkart', 'Online'), 
(3, 102, '2025-09-03', 200.00, 'Reliance Mart', 'Offline'), 
(4, 103, '2025-09-04', 1500.00, 'Myntra', 'Online'), 
(5, 103, '2025-09-06', 800.00, 'Big Bazaar', 'Offline');

SELECT * FROM CREDIT_CARD_TRANSACTIONS;


SELECT customer_id, 
COUNT(transaction_id) AS total_transactions, 
SUM(amount) AS total_spent,
AVG(amount) AS avg_spent 
FROM CREDIT_CARD_TRANSACTIONS 
GROUP BY customer_id;

SELECT customer_id, 
SUM(CASE WHEN payment_type = 'Online' THEN amount ELSE 0 END) AS online_spent, 
SUM(CASE WHEN payment_type = 'Offline' THEN amount ELSE 0 END) AS offline_spent
FROM CREDIT_CARD_TRANSACTIONS 
GROUP BY customer_id;

SELECT customer_id, 
DATEDIFF(day, MAX(transaction_date), CURRENT_DATE) AS days_since_last_txn
FROM CREDIT_CARD_TRANSACTIONS
GROUP BY customer_id;

CREATE OR REPLACE TABLE CREDIT_CARD_FEATURES AS SELECT customer_id, 
COUNT(transaction_id) AS total_transactions, 
SUM(amount) AS total_spent, 
AVG(amount) AS avg_spent, 
SUM(CASE WHEN payment_type = 'Online' THEN amount ELSE 0 END) AS online_spent, 
SUM(CASE WHEN payment_type = 'Offline' THEN amount ELSE 0 END) AS offline_spent,
DATEDIFF(day, MAX(transaction_date), CURRENT_DATE) AS days_since_last_txn 
FROM CREDIT_CARD_TRANSACTIONS 
GROUP BY customer_id;

SELECT * FROM CREDIT_CARD_FEATURES;