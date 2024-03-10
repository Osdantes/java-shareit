DROP TABLE IF EXISTS users, items, requests, booking, comments CASCADE;

CREATE TABLE IF NOT EXISTS users (
  id BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(512) NOT NULL,
  CONSTRAINT pk_user PRIMARY KEY (id),
  CONSTRAINT uq_user_email UNIQUE (email)
);

CREATE TABLE IF NOT EXISTS requests (
  id BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
  description VARCHAR(4000) NOT NULL,
  creation_date TIMESTAMP WITHOUT TIME ZONE,
  requestor_id BIGINT,
  CONSTRAINT pk_requests PRIMARY KEY (id),
  CONSTRAINT fk_requests_to_users FOREIGN KEY (requestor_id) REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS items (
  id BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
  name VARCHAR(1000) NOT NULL,
  description VARCHAR(4000) NOT NULL,
  is_available BOOLEAN,
  owner_id BIGINT,
  request_id BIGINT,
  CONSTRAINT pk_item PRIMARY KEY (id),
  CONSTRAINT fk_items_to_users FOREIGN KEY (owner_id) REFERENCES users(id),
  CONSTRAINT fk_items_to_requests FOREIGN KEY (request_id) REFERENCES requests(id)
);

CREATE TABLE IF NOT EXISTS booking (
  id BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
  start_date TIMESTAMP WITHOUT TIME ZONE,
  end_date TIMESTAMP WITHOUT TIME ZONE,
  status VARCHAR(40),
  booker_id BIGINT,
  item_id BIGINT,
  CONSTRAINT pk_booking PRIMARY KEY (id),
  CONSTRAINT fk_booking_to_users FOREIGN KEY (booker_id) REFERENCES users(id),
  CONSTRAINT fk_booking_to_items FOREIGN KEY (item_id) REFERENCES items(id)
);

CREATE TABLE IF NOT EXISTS comments (
  id BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
  text VARCHAR(4000) NOT NULL,
  author_id BIGINT,
  item_id BIGINT,
  created TIMESTAMP WITHOUT TIME ZONE,
  CONSTRAINT pk_comments PRIMARY KEY (id),
  CONSTRAINT fk_comments_to_users FOREIGN KEY (author_id) REFERENCES users(id),
  CONSTRAINT fk_comments_to_items FOREIGN KEY (item_id) REFERENCES items(id)
);