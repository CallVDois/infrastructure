CREATE TABLE systems (
    system VARCHAR(60) NOT NULL CHECK (system IN ('DRIVE','MEMBER')),
    PRIMARY KEY (system)
);

CREATE TABLE members (
    id UUID NOT NULL,
    active BOOLEAN NOT NULL,
    created_at TIMESTAMP(6) WITH TIME ZONE,
    updated_at TIMESTAMP(6) WITH TIME ZONE,
    email VARCHAR(255),
    nickname VARCHAR(255),
    username VARCHAR(255),
    synchronized_version BIGINT NOT NULL DEFAULT 0,
    PRIMARY KEY (id)
);

CREATE TABLE member_system (
    member_id UUID NOT NULL,
    system_id VARCHAR(60) NOT NULL,
    PRIMARY KEY (member_id, system_id)
);

ALTER TABLE member_system
    ADD CONSTRAINT fk_member_system_system_id FOREIGN KEY (system_id) REFERENCES systems(system);

ALTER TABLE member_system
    ADD CONSTRAINT fk_member_system_member_id FOREIGN KEY (member_id) REFERENCES members(id);

INSERT INTO systems (system) VALUES 
    ('DRIVE'),
    ('MEMBER');
