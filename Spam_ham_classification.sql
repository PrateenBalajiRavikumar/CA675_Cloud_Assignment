
---- Classify Emails as Ham or Spam

DROP TABLE IF EXISTS email_classification;
CREATE TABLE email_classification AS
SELECT 
    e.subject,
    e.`from`,
    e.`to`,
    CASE 
        WHEN s.word IS NOT NULL THEN 'spam' 
        ELSE 'ham' 
    END AS classification
FROM 
    email_data_integrity_checked e
LEFT JOIN spams s ON e.body LIKE CONCAT('%', s.word, '%');


--- top 10 results 

SELECT *
FROM email_classification
LIMIT 10;


--  display the top 10 spam emails based on the frequency of repeated spam values

SELECT 
    subject,
    `from`,
    `to`,
    COUNT(*) AS spam_count
FROM email_classification
WHERE classification = 'spam'
GROUP BY subject, `from`, `to`
ORDER BY spam_count DESC
LIMIT 10;

---To display the top 10 ham (non-spam) emails based on the frequency of repeated ham values

SELECT 
    subject,
    `from`,
    `to`,
    COUNT(*) AS ham_count
FROM email_classification
WHERE classification = 'ham'
GROUP BY subject, `from`, `to`
ORDER BY ham_count DESC
LIMIT 10;


--To get the count of spam and ham emails in your email_classification table

SELECT 
    classification,
    COUNT(*) AS count
FROM email_classification
GROUP BY classification;

--To specifically get the count of spam emails in your email_classification table

SELECT 
    COUNT(*) AS spam_count
FROM email_classification
WHERE classification = 'spam';


-- Ham count 

SELECT 
    COUNT(*) AS ham_count
FROM email_classification
WHERE classification = 'ham';

-- To get the count of spam and ham emails along with their email ID , body and count

SELECT 
    thread_id,
    COUNT(*) AS spam_count
FROM email_classification
WHERE classification = 'spam'
GROUP BY thread_id
ORDER BY spam_count DESC
LIMIT 10;

SELECT 
    thread_id,
    COUNT(*) AS ham_count
FROM email_classification
WHERE classification = 'ham'
GROUP BY thread_id
ORDER BY ham_count DESC
LIMIT 10;


