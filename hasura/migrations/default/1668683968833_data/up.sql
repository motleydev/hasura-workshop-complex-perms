SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET escape_string_warning = off;
CREATE TABLE public."group" (
    id integer NOT NULL,
    name text NOT NULL
);
CREATE SEQUENCE public.group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.group_id_seq OWNED BY public."group".id;
CREATE TABLE public.group_member (
    g_id integer NOT NULL,
    m_id integer NOT NULL
);
CREATE TABLE public.light_states (
    value text NOT NULL
);
CREATE TABLE public.member (
    id integer NOT NULL,
    name text NOT NULL
);
CREATE SEQUENCE public.member_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.member_id_seq OWNED BY public.member.id;
CREATE TABLE public.switch (
    id integer NOT NULL,
    state text NOT NULL
);
CREATE TABLE public.switch_group (
    s_id integer NOT NULL,
    g_id integer NOT NULL
);
CREATE SEQUENCE public.switch_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.switch_id_seq OWNED BY public.switch.id;
ALTER TABLE ONLY public."group" ALTER COLUMN id SET DEFAULT nextval('public.group_id_seq'::regclass);
ALTER TABLE ONLY public.member ALTER COLUMN id SET DEFAULT nextval('public.member_id_seq'::regclass);
ALTER TABLE ONLY public.switch ALTER COLUMN id SET DEFAULT nextval('public.switch_id_seq'::regclass);
ALTER TABLE ONLY public.group_member
    ADD CONSTRAINT group_member_pkey PRIMARY KEY (g_id, m_id);
ALTER TABLE ONLY public."group"
    ADD CONSTRAINT group_name_key UNIQUE (name);
ALTER TABLE ONLY public."group"
    ADD CONSTRAINT group_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.light_states
    ADD CONSTRAINT light_states_pkey PRIMARY KEY (value);
ALTER TABLE ONLY public.member
    ADD CONSTRAINT member_name_key UNIQUE (name);
ALTER TABLE ONLY public.member
    ADD CONSTRAINT member_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.switch_group
    ADD CONSTRAINT switch_group_pkey PRIMARY KEY (s_id, g_id);
ALTER TABLE ONLY public.switch
    ADD CONSTRAINT switch_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.group_member
    ADD CONSTRAINT group_member_g_id_fkey FOREIGN KEY (g_id) REFERENCES public."group"(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.group_member
    ADD CONSTRAINT group_member_m_id_fkey FOREIGN KEY (m_id) REFERENCES public.member(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.switch_group
    ADD CONSTRAINT switch_group_g_id_fkey FOREIGN KEY (g_id) REFERENCES public."group"(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.switch_group
    ADD CONSTRAINT switch_group_s_id_fkey FOREIGN KEY (s_id) REFERENCES public.switch(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.switch
    ADD CONSTRAINT switch_state_fkey FOREIGN KEY (state) REFERENCES public.light_states(value) ON UPDATE RESTRICT ON DELETE RESTRICT;
