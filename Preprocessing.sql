---- Extract and Cleanse Email Data:
CREATE TABLE temp_email_extract AS 
SELECT 
    TRIM(REGEXP_REPLACE(REGEXP_EXTRACT(sender_extracted, 'From:(.*) To: ', 1), 'To:(.*)', '')) AS sender,
    TRIM(REGEXP_REPLACE(REGEXP_EXTRACT(subject_extracted, 'Subject:(.*) Content-Type:'), 'Content-Type:(.*)', '')) AS subject,
    TRIM(REGEXP_REPLACE(REGEXP_EXTRACT(message_extracted, '\\.nsf(.*)|\\.pst(.*)', 0), '\\.pst|\\.nsf', '')) AS message
FROM (
    SELECT 
        message AS sender_extracted,
        message AS subject_extracted,
        SUBSTRING(message, LOCATE('X-FileName:', message) + LENGTH('X-FileName:'), LOCATE('  ', message) - LENGTH('  ') - 2) AS message_extracted
    FROM email_data
) subquery
WHERE TRIM(REGEXP_REPLACE(REGEXP_EXTRACT(sender_extracted, 'From:(.*) To: ', 1), 'To:(.*)', '')) NOT LIKE ' ';


--- Remove Stopwords:

DROP TABLE IF EXISTS cleaned_email_data;
CREATE TABLE cleaned_email_data AS 
SELECT 
    sender, 
    subject,
    REGEXP_REPLACE(LOWER(message), ' me | my | myself | we | our | ours | ourselves | you | your | yours | yourself | yourselves | he | him | his | himself | she | her | hers | herself | it | its | itself | they | them | their | theirs | themselves | what | which | who | whom | this | that | these | those | am | is | are | was | were | be | been | being | have | has | had | having | do | does | did | doing | an | the | and | but | if | or | because | as | until | while | of | at | by | for | with | about | against | between | into | through | during | before | after | above | below | to | from | up | down | in | out | on | off | over | under | again | further | then | once | here | there | when | where | why | how | all | any | both | each | few | more | most | other | some | such | no | nor | not | only | own | same | so | than | too | very | can | will | just | don | should | now ', '') AS message
FROM temp_email_extract;


