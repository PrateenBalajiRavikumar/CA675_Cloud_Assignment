
---First setop of creating a table and loading data from CSV file to tabble 

CREATE EXTERNAL TABLE email_data(
    thread_id STRING,
    subject STRING,
    timestamp TIMESTAMP,
    from STRING,
    to STRING,
    body STRING
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
    "separatorChar" = ","
)
STORED AS TEXTFILE
LOCATION 's3://mycloudbucket2/';

--- get record count of the loaded data
select count(*) from email_data;

--create a table spam and insert spam words

DROP TABLE IF EXISTS spams;
CREATE TABLE spams (
    word STRING
);
INSERT INTO spams (word) VALUES 
('free'), ('winner'), ('win'), ('claim'), ('prize'), 
('offer'), ('urgent'), ('important'), ('attention'), ('alert'),
('guaranteed'), ('congratulations'), ('selected'), ('lucky'), ('opportunity'),
('chance'), ('risk-free'), ('no risk'), ('promise'), ('investment'),
('trial'), ('discount'), ('savings'), ('bargain'), ('best price'),
('cost'), ('credit'), ('income'), ('profit'), ('money'),
('earn'), ('cash'), ('bonus'), ('billion'), ('million'),
('fortune'), ('rich'), ('wealth'), ('payout'), ('jackpot'),
('lottery'), ('casino'), ('bets'), ('betting'), ('gamble'),
('viagra'), ('pharmacy'), ('meds'), ('pills'), ('drugs'),
('replica'), ('fake'), ('copy'), ('luxury'), ('rolex'),('100% free'),('Get out of debt'),('You are a winner'),
('Free membership'),('Special promotion'),('unsubscribe');

