DROP TABLE IF EXISTS bounties;

CREATE TABLE bounties(
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  species VARCHAR(255),
  bounty_value INT,
  homeworld VARCHAR(255)
);
