ALTER TABLE members
    ADD COLUMN quota_in_bytes BIGINT NOT NULL DEFAULT 0;

UPDATE members
SET quota_in_bytes = CASE
    WHEN quota_unit = 'BYTE' THEN quota_amount
    WHEN quota_unit = 'KILOBYTE' THEN quota_amount * 1024
    WHEN quota_unit = 'MEGABYTE' THEN quota_amount * 1024 * 1024
    WHEN quota_unit = 'GIGABYTE' THEN quota_amount * 1024 * 1024 * 1024
    WHEN quota_unit = 'TERABYTE' THEN quota_amount * 1024 * 1024 * 1024 * 1024
    ELSE 0
END;

ALTER TABLE members
    ADD COLUMN quota_request_in_bytes BIGINT;

UPDATE members
SET quota_request_in_bytes = CASE
    WHEN quota_request_unit = 'BYTE' THEN quota_request_amount
    WHEN quota_request_unit = 'KILOBYTE' THEN quota_request_amount * 1024
    WHEN quota_request_unit = 'MEGABYTE' THEN quota_request_amount * 1024 * 1024
    WHEN quota_request_unit = 'GIGABYTE' THEN quota_request_amount * 1024 * 1024 * 1024
    WHEN quota_request_unit = 'TERABYTE' THEN quota_request_amount * 1024 * 1024 * 1024 * 1024
    ELSE NULL
END;