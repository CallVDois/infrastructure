create table acl_entries (
    id uuid not null,
    acl_id uuid not null,
    member_id uuid not null,
    permission_type varchar(255) not null check (permission_type in ('ACCESS')),
    access_permission varchar(255) check (access_permission in ('MANAGE', 'WRITE', 'READ')),
    entry_type varchar(255) not null check (entry_type in ('DIRECT', 'INHERITED')),
    granted_at timestamp(6) with time zone not null,
    primary key (id)
);
create table acls (
    id uuid not null,
    resource_id varchar(36) not null,
    resource_type varchar(36) check (resource_type in ('FILE', 'FOLDER')) not null,
    resource_owner uuid not null,
    created_at timestamp(6) with time zone not null,
    updated_at timestamp(6) with time zone not null,
    primary key (id)
);
create table file_access_acls (
    file_id uuid not null,
    member_id uuid not null,
    effective_access_permission varchar(30) check (
        effective_access_permission in ('MANAGE', 'WRITE', 'READ')
    ),
    primary key (file_id, member_id)
);
create table file_sharings (
    id uuid not null,
    file_id uuid not null,
    shared_by uuid,
    shared_to uuid,
    virtual_folder uuid,
    created_at timestamp(6) with time zone,
    primary key (id)
);
create table files (
    id uuid not null,
    creator_id uuid not null,
    owner_id uuid not null,
    folder_id uuid not null,
    name varchar(255) not null,
    content_type varchar(255) not null,
    content_size bigint not null,
    content_storage_key varchar(255) not null,
    updated_by uuid not null,
    deleted_by uuid,
    created_at timestamp(6) with time zone not null,
    deleted_at timestamp(6) with time zone,
    updated_at timestamp(6) with time zone not null,
    is_deleted boolean not null,
    primary key (id)
);
create table folder_access_acls (
    folder_id uuid not null,
    member_id uuid not null,
    effective_access_permission varchar(30) check (
        effective_access_permission in ('MANAGE', 'WRITE', 'READ')
    ),
    primary key (folder_id, member_id)
);
create table folder_sharings (
    id uuid not null,
    folder_id uuid not null,
    virtual_folder uuid not null,
    shared_by uuid not null,
    shared_to uuid not null,
    created_at timestamp(6) with time zone not null,
    primary key (id)
);
create table folders (
    id uuid not null,
    creator_id uuid not null,
    owner_id uuid not null,
    parent_folder_id uuid,
    name varchar(255) not null,
    is_root_folder boolean not null,
    is_default_shared_inbox boolean not null,
    created_at timestamp(6) with time zone not null,
    deleted_at timestamp(6) with time zone,
    updated_at timestamp(6) with time zone not null,
    primary key (id)
);
create table members (
    id uuid not null,
    username varchar(255),
    nickname varchar(255),
    quota_amount bigint not null,
    quota_unit varchar(255) not null check (
        quota_unit in (
            'BYTE',
            'KILOBYTE',
            'MEGABYTE',
            'GIGABYTE',
            'TERABYTE'
        )
    ),
    quota_in_bytes bigint not null,
    quota_request_amount bigint,
    quota_request_unit varchar(255) check (
        quota_request_unit in (
            'BYTE',
            'KILOBYTE',
            'MEGABYTE',
            'GIGABYTE',
            'TERABYTE'
        )
    ),
    quota_request_in_bytes bigint,
    quota_requested_at timestamp(6) with time zone,
    has_system_access boolean not null,
    created_at timestamp(6) with time zone,
    updated_at timestamp(6) with time zone,
    synchronized_version bigint,
    primary key (id)
);
alter table if exists acl_entries
add constraint fk_acl_entries_acl_id foreign key (acl_id) references acls;
alter table if exists file_sharings
add constraint fk_file_sharings_file_id foreign key (file_id) references files;
alter table if exists folder_sharings
add constraint fk_folder_sharings_folder_id foreign key (folder_id) references folders;