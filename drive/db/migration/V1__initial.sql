CREATE TABLE files (
    id UUID NOT NULL,
    owner_id VARCHAR(255) NOT NULL,
    folder_id UUID NOT NULL,
    name VARCHAR(255) NOT NULL,
    content_type VARCHAR(255) NOT NULL,
    content_location VARCHAR(255) NOT NULL,
    content_size BIGINT NOT NULL,
    created_at TIMESTAMP(6) WITH TIME ZONE NOT NULL,
    updated_at TIMESTAMP(6) WITH TIME ZONE NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE folders (
    id UUID NOT NULL,
    is_root_folder BOOLEAN NOT NULL,
    name VARCHAR(255) NOT NULL,
    owner_id VARCHAR(255) NOT NULL,
    parent_folder_id UUID,
    created_at TIMESTAMP(6) WITH TIME ZONE NOT NULL,
    updated_at TIMESTAMP(6) WITH TIME ZONE NOT NULL,
    deleted_at TIMESTAMP(6) WITH TIME ZONE,
    PRIMARY KEY (id)
);

CREATE TABLE members (
    id VARCHAR(255) NOT NULL,
    username VARCHAR(255),
    nickname VARCHAR(255),
    quota_ammount BIGINT NOT NULL,
    quota_unit VARCHAR(255) NOT NULL CHECK (quota_unit IN ('BYTE', 'KILOBYTE', 'MEGABYTE', 'GIGABYTE', 'TERABYTE')),
    quota_request_ammount BIGINT,
    quota_request_unit VARCHAR(255) CHECK (quota_request_unit IN ('BYTE', 'KILOBYTE', 'MEGABYTE', 'GIGABYTE', 'TERABYTE')),
    quota_requested_at TIMESTAMP(6) WITH TIME ZONE,
    created_at TIMESTAMP(6) WITH TIME ZONE,
    updated_at TIMESTAMP(6) WITH TIME ZONE,
    synchronized_version BIGINT,
    PRIMARY KEY (id)
);

CREATE TABLE sub_folders (
    parent_folder_id UUID NOT NULL,
    sub_folder_id UUID NOT NULL,
    name VARCHAR(255) NOT NULL,
    PRIMARY KEY (parent_folder_id, sub_folder_id)
);

ALTER TABLE IF EXISTS sub_folders
    ADD CONSTRAINT fk_sub_folders_parent_folder_id
    FOREIGN KEY (parent_folder_id)
    REFERENCES folders;
