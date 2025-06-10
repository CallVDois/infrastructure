ALTER TABLE members
    ADD COLUMN synchronized_version BIGINT NOT NULL DEFAULT 0;