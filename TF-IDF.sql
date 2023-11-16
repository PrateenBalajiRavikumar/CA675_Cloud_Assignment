----Calculate Term Frequency (TF) for spam emails

CREATE TABLE spam_term_frequency AS
SELECT
    e.thread_id AS account_id,
    term,
    COUNT(*) AS term_frequency
FROM
    email_classification e
LATERAL VIEW EXPLODE(SPLIT(e.body, ' ')) AS term
WHERE
    e.classification = 'spam'
GROUP BY
    e.thread_id, term;

-- Calculate Inverse Document Frequency (IDF) for spam emails

CREATE TABLE spam_inverse_document_frequency AS
SELECT
    term,
    LOG(CAST(COUNT(DISTINCT account_id) AS DOUBLE) / COUNT(*) + 1) AS inverse_document_frequency
FROM spam_term_frequency
GROUP BY
    term;


-- Calculate TF-IDF for spam emails

CREATE TABLE spam_tf_idf AS
SELECT
    stf.account_id,
    stf.term,
    stf.term_frequency * idf.inverse_document_frequency AS tf_idf
FROM
    spam_term_frequency stf
JOIN
    spam_inverse_document_frequency idf
ON
    stf.term = idf.term;

--Identify Top 10 Keywords for Each Spam Account

WITH ranked_terms AS (
    SELECT
        account_id,
        term,
        tf_idf,
        ROW_NUMBER() OVER (PARTITION BY account_id ORDER BY tf_idf DESC) AS rank
    FROM
        spam_tf_idf
)
SELECT
    account_id,
    term,
    tf_idf
FROM
    ranked_terms
WHERE
    rank <= 10;
