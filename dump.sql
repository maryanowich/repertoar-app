--
-- PostgreSQL database dump
--

\restrict w7fnqReZpHlyr7a651wegmV2mo42YFVqkfbKC5rrcK17hn9ammg5T4KSdLKaJ5z

-- Dumped from database version 18.3 (Homebrew)
-- Dumped by pg_dump version 18.3 (Homebrew)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: login_tokens; Type: TABLE; Schema: public; Owner: markomarjanovic
--

CREATE TABLE public.login_tokens (
    token text NOT NULL,
    user_id integer,
    expires_at timestamp without time zone NOT NULL
);


ALTER TABLE public.login_tokens OWNER TO markomarjanovic;

--
-- Name: mixes; Type: TABLE; Schema: public; Owner: markomarjanovic
--

CREATE TABLE public.mixes (
    id bigint NOT NULL,
    name text,
    note text,
    created_at text
);


ALTER TABLE public.mixes OWNER TO markomarjanovic;

--
-- Name: mixes_id_seq; Type: SEQUENCE; Schema: public; Owner: markomarjanovic
--

CREATE SEQUENCE public.mixes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.mixes_id_seq OWNER TO markomarjanovic;

--
-- Name: mixes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: markomarjanovic
--

ALTER SEQUENCE public.mixes_id_seq OWNED BY public.mixes.id;


--
-- Name: rehearsal_songs; Type: TABLE; Schema: public; Owner: markomarjanovic
--

CREATE TABLE public.rehearsal_songs (
    id bigint NOT NULL,
    rehearsal_id bigint,
    song_id bigint,
    version_link text,
    "position" integer,
    is_mix integer DEFAULT 0
);


ALTER TABLE public.rehearsal_songs OWNER TO markomarjanovic;

--
-- Name: rehearsal_songs_id_seq; Type: SEQUENCE; Schema: public; Owner: markomarjanovic
--

CREATE SEQUENCE public.rehearsal_songs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.rehearsal_songs_id_seq OWNER TO markomarjanovic;

--
-- Name: rehearsal_songs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: markomarjanovic
--

ALTER SEQUENCE public.rehearsal_songs_id_seq OWNED BY public.rehearsal_songs.id;


--
-- Name: rehearsals; Type: TABLE; Schema: public; Owner: markomarjanovic
--

CREATE TABLE public.rehearsals (
    id bigint NOT NULL,
    date text,
    note text,
    status text DEFAULT 'planned'::text,
    name text
);


ALTER TABLE public.rehearsals OWNER TO markomarjanovic;

--
-- Name: rehearsals_id_seq; Type: SEQUENCE; Schema: public; Owner: markomarjanovic
--

CREATE SEQUENCE public.rehearsals_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.rehearsals_id_seq OWNER TO markomarjanovic;

--
-- Name: rehearsals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: markomarjanovic
--

ALTER SEQUENCE public.rehearsals_id_seq OWNED BY public.rehearsals.id;


--
-- Name: setlist_items; Type: TABLE; Schema: public; Owner: markomarjanovic
--

CREATE TABLE public.setlist_items (
    id bigint NOT NULL,
    setlist_id bigint,
    item_type text,
    item_id bigint,
    "position" bigint
);


ALTER TABLE public.setlist_items OWNER TO markomarjanovic;

--
-- Name: setlist_items_id_seq; Type: SEQUENCE; Schema: public; Owner: markomarjanovic
--

CREATE SEQUENCE public.setlist_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.setlist_items_id_seq OWNER TO markomarjanovic;

--
-- Name: setlist_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: markomarjanovic
--

ALTER SEQUENCE public.setlist_items_id_seq OWNED BY public.setlist_items.id;


--
-- Name: setlists; Type: TABLE; Schema: public; Owner: markomarjanovic
--

CREATE TABLE public.setlists (
    id bigint NOT NULL,
    name text,
    date text,
    note text
);


ALTER TABLE public.setlists OWNER TO markomarjanovic;

--
-- Name: setlists_id_seq; Type: SEQUENCE; Schema: public; Owner: markomarjanovic
--

CREATE SEQUENCE public.setlists_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.setlists_id_seq OWNER TO markomarjanovic;

--
-- Name: setlists_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: markomarjanovic
--

ALTER SEQUENCE public.setlists_id_seq OWNED BY public.setlists.id;


--
-- Name: songs; Type: TABLE; Schema: public; Owner: markomarjanovic
--

CREATE TABLE public.songs (
    id bigint NOT NULL,
    title text NOT NULL,
    artist text NOT NULL,
    key text NOT NULL,
    tempo text NOT NULL,
    genre text NOT NULL,
    region text,
    vocal text,
    lyrics text,
    mix_id bigint,
    mix_order bigint,
    origin text NOT NULL,
    theme text,
    is_instrumental bigint DEFAULT '0'::bigint,
    score_pdf text,
    status text DEFAULT 'repertoar'::text,
    planned_mix text,
    created_at timestamp without time zone DEFAULT now(),
    mix_lyrics text
);


ALTER TABLE public.songs OWNER TO markomarjanovic;

--
-- Name: songs_id_seq; Type: SEQUENCE; Schema: public; Owner: markomarjanovic
--

CREATE SEQUENCE public.songs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.songs_id_seq OWNER TO markomarjanovic;

--
-- Name: songs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: markomarjanovic
--

ALTER SEQUENCE public.songs_id_seq OWNED BY public.songs.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: markomarjanovic
--

CREATE TABLE public.users (
    id integer NOT NULL,
    email text NOT NULL,
    role text DEFAULT 'viewer'::text,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.users OWNER TO markomarjanovic;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: markomarjanovic
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO markomarjanovic;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: markomarjanovic
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: v_brojzanr; Type: VIEW; Schema: public; Owner: markomarjanovic
--

CREATE VIEW public.v_brojzanr AS
 SELECT genre,
    count(*) AS genre_count
   FROM public.songs
  GROUP BY genre
 HAVING (count(*) > 1);


ALTER VIEW public.v_brojzanr OWNER TO markomarjanovic;

--
-- Name: v_home_stats; Type: VIEW; Schema: public; Owner: markomarjanovic
--

CREATE VIEW public.v_home_stats AS
 SELECT count(*) AS total_songs,
    sum(
        CASE
            WHEN (origin = 'Strano'::text) THEN 1
            ELSE 0
        END) AS total_strano,
    sum(
        CASE
            WHEN (origin = 'Domaće'::text) THEN 1
            ELSE 0
        END) AS total_domace,
    sum(
        CASE
            WHEN (vocal = 'Muško'::text) THEN 1
            ELSE 0
        END) AS total_musko,
    sum(
        CASE
            WHEN (vocal = 'Žensko'::text) THEN 1
            ELSE 0
        END) AS total_zensko,
    sum(
        CASE
            WHEN (is_instrumental = 1) THEN 1
            ELSE 0
        END) AS total_instrumental
   FROM public.songs
  WHERE (status = 'repertoar'::text);


ALTER VIEW public.v_home_stats OWNER TO markomarjanovic;

--
-- Name: mixes id; Type: DEFAULT; Schema: public; Owner: markomarjanovic
--

ALTER TABLE ONLY public.mixes ALTER COLUMN id SET DEFAULT nextval('public.mixes_id_seq'::regclass);


--
-- Name: rehearsal_songs id; Type: DEFAULT; Schema: public; Owner: markomarjanovic
--

ALTER TABLE ONLY public.rehearsal_songs ALTER COLUMN id SET DEFAULT nextval('public.rehearsal_songs_id_seq'::regclass);


--
-- Name: rehearsals id; Type: DEFAULT; Schema: public; Owner: markomarjanovic
--

ALTER TABLE ONLY public.rehearsals ALTER COLUMN id SET DEFAULT nextval('public.rehearsals_id_seq'::regclass);


--
-- Name: setlist_items id; Type: DEFAULT; Schema: public; Owner: markomarjanovic
--

ALTER TABLE ONLY public.setlist_items ALTER COLUMN id SET DEFAULT nextval('public.setlist_items_id_seq'::regclass);


--
-- Name: setlists id; Type: DEFAULT; Schema: public; Owner: markomarjanovic
--

ALTER TABLE ONLY public.setlists ALTER COLUMN id SET DEFAULT nextval('public.setlists_id_seq'::regclass);


--
-- Name: songs id; Type: DEFAULT; Schema: public; Owner: markomarjanovic
--

ALTER TABLE ONLY public.songs ALTER COLUMN id SET DEFAULT nextval('public.songs_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: markomarjanovic
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: login_tokens; Type: TABLE DATA; Schema: public; Owner: markomarjanovic
--

COPY public.login_tokens (token, user_id, expires_at) FROM stdin;
\.


--
-- Data for Name: mixes; Type: TABLE DATA; Schema: public; Owner: markomarjanovic
--

COPY public.mixes (id, name, note, created_at) FROM stdin;
2	Slavonski mix 1	\N	2026-02-23 10:20:32
3	Country mix 1	\N	2026-02-23 10:20:32
4	Zabavni kratki mix 1	\N	2026-02-23 10:20:32
5	Plesni mix 1	\N	2026-02-23 10:20:32
6	Rock mix 1	\N	2026-02-23 10:20:32
10	Fosili Mix 2	\N	2026-03-12 10:23:58.437563+01
12	Grdović Mix	\N	2026-03-28 09:34:56.013054+01
\.


--
-- Data for Name: rehearsal_songs; Type: TABLE DATA; Schema: public; Owner: markomarjanovic
--

COPY public.rehearsal_songs (id, rehearsal_id, song_id, version_link, "position", is_mix) FROM stdin;
56	3	109	\N	1	0
57	3	20	\N	2	0
72	3	130	\N	3	0
58	3	140	\N	4	0
59	3	141	\N	5	0
65	3	122	\N	6	0
61	3	39	\N	7	0
62	3	2	\N	8	0
\.


--
-- Data for Name: rehearsals; Type: TABLE DATA; Schema: public; Owner: markomarjanovic
--

COPY public.rehearsals (id, date, note, status, name) FROM stdin;
3	2026-03-24	Zabavni promo	planned	PROMO Video 1
\.


--
-- Data for Name: setlist_items; Type: TABLE DATA; Schema: public; Owner: markomarjanovic
--

COPY public.setlist_items (id, setlist_id, item_type, item_id, "position") FROM stdin;
\.


--
-- Data for Name: setlists; Type: TABLE DATA; Schema: public; Owner: markomarjanovic
--

COPY public.setlists (id, name, date, note) FROM stdin;
\.


--
-- Data for Name: songs; Type: TABLE DATA; Schema: public; Owner: markomarjanovic
--

COPY public.songs (id, title, artist, key, tempo, genre, region, vocal, lyrics, mix_id, mix_order, origin, theme, is_instrumental, score_pdf, status, planned_mix, created_at, mix_lyrics) FROM stdin;
2	Nećemo noćas doma	Zlatko Pejaković	D	Brza	Fešta	Hrvatska	Muško	Pustimo brige sve ce jednom proc'\nnek' pjesma traje duboko u noc\npruzimo ruke jedni drugima\ntko zna sto sutra nosi sudbina\nza sretne godine\nza nove susrete, za nas\n\nZivot je samo prasina i dim\nne treba nikad zalit' ni za cim\npod ovim nebom svakog ceka dom\nnek' srca nocas luduju po svom\nza sretne godine\nza nove susrete, za nas\n\nRef.\nNecemo nocas doma\nnecemo do zore\njednom se samo zivi\njednom se umire\n\nNecemo nocas doma\ndoma nas znaju svi\nza drustvo staro\njednu jos nazdravi\n\nPustimo brige sve ce jednom proc'\nnek' pjesma traje duboko u noc\npruzimo ruke jedni drugima\ntko zna sto sutra nosi sudbina\nza sretne godine\nsto kraj nas prolaze, za nas	\N	\N	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
3	Sve poštivam, svoje uživam	Miroslav Škoro	D	Brza	Tambure	Slavonija	Muško	Kad mi padne sesir na celo\npa izmjerim cestu kroz selo\nzamnom ide vojska vesela\nsto tambura, moja kapela\n\nRef.\nPoznaju me i selo i grad\nja sam lola prava slavonska\nkad zaigra drmes lagani\noce srce puknut u meni\nsve postivam, svoje uzivam\n\nGovore mi da se ozenim\ni corava posla okanim\nsto cu kad je jace od mene\nganjat suknje kitit tambure\n\nRef.\n\nHtjeli neki da se iselim\ndjedovinu svoju ostavim\nal' bi prije umro ja za nju\nSlavoniju moju ponosnu\n\nRef.	2	1	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
4	Garavušo garava	Miroslav Škoro	D	Brza	Tambure	Slavonija	Muško	Garavuso garava\nti si mene varala\nti si mene varala\nkad si mi govorila\n\nRef. 2x\nBit ces moja\nili nicija\ngaravuso garava\nti si meni lagala\n\nZorom lipa mirise\nsrce moje uzdise\nsrce moje uzdise\nnema mi garavuse\n\nRef. 2x\n\nPriskocit cu plotove\nprivrnut cu stolove\nprivrnut cu stolove\ncuro moja, zbog tebe\n\nRef. 2x	2	2	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
5	Željo moja	Doris Dragović	C	Srednja	Balada	Hrvatska	Žensko	Voljela sam te i jos te volim\ndajem iskreno sve\nnoc je ova crna bez tebe\n\nAko ima srece vratit ces se\nmoja kazna, moj grijeh\ntiho, tiho suzo, ne daj se\n\nRef.\nZeljo moja, tugo moja\njos sam tvoja, jos si moj\nsve, sve me boli od tebe\nzeljo moja, tugo moja\n\nAko ima srece vratit ces se\nmoja kazna, moj grijeh\ntiho, tiho suzo, ne daj se\n\nRef.\n\nSve, sve me boli od tebe\nzeljo moja, tugo moja	\N	\N	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
8	A kind of magic	Queen	D	Brza	Pop / Rock	\N	Žensko	It's a kind of magic,It's a kind of magic, A kind of magic\nOne dream one soul one prize one goal\nOne golden glance of what should be\nIt's a kind of magic\nOne shaft of light that shows the way\nNo mortal man can win this day\nIt's a kind of magic\nThe bell that rings inside your mind\nIs challenging the doors of time\nIt's a kind of magic\nThe waiting seems eternity\nThe day will dawn of sanity\nIs this a kind of magic\nIt's a kind of magic\nThere can be only one\nThis rage that lasts a thousand years\nWill soon be done\n\nThis flame that burns inside of me\nI'm here in secret harmonies\nIt's a kind of magic\nThe bell that rings inside your mind\nIs challenging the doors of time\n\nsolo guitar 2 kruga (2x)\n\nIt's a kind of magic  2x\n\nThe rage that lasts a thousand years\nWill soon be\nWill soon be\nWill soon be done\nThis is a kind of magic\nThere can be only one\nThis rage that lasts a thousand years\nWill soon be done – done\n\nsolo bas 1x\nsvi instrumenti 3x - bubanj break -\n\nMagic magic magic magic\n\nsolo guitar 4x\n\nThe rage that lasts a thousand years\nWill soon be\nWill soon be\nWill soon be\nWill soon be\nWill soon be done\n\nWill soon be done	\N	\N	Strano	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
10	Ako me ostaviš	Mišo Kovač	D	Spora	Balada	Dalmacija	Muško	VER1\nSamo jednom ljubav pokuca na vrata\nda te rani ceznjom i gorcinom\nda te vodi k'o pticu bez jata\nda te tjesi vinom\n\nVER2\nSamo jednom ljubav pokuca na vrata\nda ti pruzi snove i ljepotu\nda ti stavi okove od zlata\njednom u zivotu\n\nRef.\nAko me ostavis, kad pozelis kraj\ni nebo ce plakati, izgubit' ce sjaj\nako me ostavis, ne rusi grubo sve\npusti da vjerujem da voljela si me\n\nSolo\n\nVER2\n\nRef. 2x	\N	3	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
7	17 mi je godina	EnJoy	A	Srednja	Zabavno	Hrvatska	Žensko	TEMA 2x\r\n\r\nM Šalje me noćas nebo po tebe\r\nL Da me spasiš od dosade\r\nM Ja bih da te vodim u svoj stan\r\nL Da me malo provozaš\r\nM Oho, oho da te provozam\r\nM O,oho da te provozam\r\n\r\nTEMA 2x\r\n\r\nM Sva zadrhtis kada čujes rock′n'roll\r\nL Rock′n'roll je pola ljubav, pola bol\r\nM Znoj ti lijepi majicu uz tijelo\r\nL Ne gledaj me da nam ne bi prisjelo\r\nL Oho, da ne bi prisjelo\r\nM Oho, da ne bi prisjelo\r\n\r\nL Sedamnaest mi je godina\r\nJoš se nisam ljubila\r\nM Sedamnaest ti je godina\r\nBaš bi probala\r\nL Sedamnaest mi je godina\r\nJoš se nisam ljubila\r\nM Zar još treba godina\r\nDa bi probala\r\n\r\nTEMA 2x\r\n\r\nM Šalje me noćas nebo po tebe\r\nL Da me spasiš od dosade\r\nM Ja bih da te vodim u svoj stan\r\nL Da me malo provozaš\r\nM oho, oho da te provozam\r\nOho,oho da te provozam\r\n\r\nL Sva zadrhtim kada čujem rock'n′roll\r\nM rock′n'roll je pola ljubav, pola bol\r\nL Znoj mi lijepi majicu uz tijelo\r\nM Ne gledaj me da nam ne bi prisjelo\r\nL oho, da ne bi prisjelo\r\nM Oho, da ne bi prisjelo\r\n\r\nL Sedamnaest mi je godina\r\nJoš se nisam ljubila\r\nM Sedamnaest ti je godina\r\nBaš bi probala\r\nL Sedamnaest mi je godina\r\nJoš se nisam ljubila\r\nM Zar još treba godina\r\nDa bi probala\r\n\r\nTEMA 2x\r\n\r\nL Sedamnaest mi je godina\r\nI još se nisam ljubila\r\nM Sedamnaest ti je godina\r\nBaš bi probala\r\nL Sedamnaest mi je godina\r\nJoš se nisam ljubila\r\nM Zar još treba godina\r\nDa bi probala\r\n\r\nL Sedamnaest mi je godina\r\nBaš bi probala\r\nM Sedamnaest ti je godina L  baš bi probala	\N	3	Domaće		0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
1	Večeras je naša fešta	Tomislav Ivčić	G	Brza	Fešta	Dalmacija	Muško	Svako misto svoju festu ima\nsvako misto ima svoj dan\na festa draga je svima\njer tu se piva po cili dan\n\nA mi volimo festu\ni ribu kod staroga Duje\nveceras je nasa festa\nnek' se daleko cuje\n\nRef. 2x\nVeceras je nasa festa\nveceras se vino pije\nnek' se igra, nek' se piva\njer ko ne piva Dalmatinac nije	12	1	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	Uvod 2x\r\n\r\nVerse\r\n\r\nSvako misto svoju feštu ima\r\nI svako misto ima svoj dan\r\nA fešta draga je svima\r\nJer tu se piva po cili dan\r\nA mi volimo feštu\r\nI ribu kod staroga Duje\r\n\r\nVečeras je naša fešta\r\nNek se daleko čuje\r\n\r\nRefren 2x\r\nVečeras je naša fešta \r\nVečeras se vino pije\r\nNek se igra nek se piva\r\nJer ko ne piva Dalmatinac nije\r\n\r\nInstrumental 1x\r\n
11	Ako ne znas šta je bilo	Marko Perković Thompson	Fism	Srednja	Domoljubne	Hrvatska	Muško	Ako ne znas sta je bilo 2x\n\nKazu da sam lud, da je novo vrijeme\nI da su prosli dani pjesama za tebe\nA meni tako dodje nakon case vina\nI da ih pitam je l' to i vasa domovina 2x\n\nTi si rodjen sine u vrijeme slobode\nRasti da je branis kad ti stari ode\n\nRef.\nAko ne znas sta je bilo nek' ti kaze Lika\nPitaj svaki kamen naseg grada Dubrovnika\nPitaj Zadar i Kotare, zide Sibenika\nAko ne znas milo moje, upitaj heroje\n\nPitaj Dunav sta je bilo oko Vukovara\nI Velebit, hladan kamen, nek' ti odgovara\nJe l' se Gospa Hercegovska suza naplakala\nTo upitaj milo moje putem do Mostara\n\nAko ne znas sta je bilo\n\nJe l' moguce da ste zaspali na strazi\nZakletva barjaku da vise ne važi\nJe l' moguce da ste zavezali oči\nI ne cujete tudje korake u noći 2x\n\nTi si rodjen sine u vrijeme slobode\nRasti da je branis kad ti stari ode\n\nRef.	\N	2	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
12	Ako su to samo bile laži	Plavi Orkestar	A	Brza	Pop / Rock	Ex-Yu	Muško	Zivot ide dalje\nzivot brzo prolazi\nali osjecam da\nto vise nisi ti, a ni ja\n\nMozda bi i mogli\npokusati ponovo\nal' bojim se da\novaj je put gotovo\n\nAl' samo ti\nmi ubrzavas disanje\njer se ja, jos uvijek\npalim na tebe\n\nRef.\nAko su to samo bile lazi\nlazimo se bar jos malo\nako su to samo bile varke\nvarajmo se, varajmo\n\nLjubavi i mrznje\ntesko je preskociti zid\nal' bojim se da\ndobar smo par, bili mi\n\nJer samo ti\nmi ubrzavas disanje\njer se ja, jos uvijek\npalim na tebe\n\nRef.	\N	\N	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
13	Balkan	Azra	G	Brza	Pop / Rock	Ex-Yu	Žensko	Jednog dana nema me\nda nikada ne dođem\nPrijatelje koje znam\nne poznajem kad prođem\n\nKao da me nikada\nna svijetu nije bilo\nKao da me njezino tijelo\nnije htjelo\n\nMoja kita miruje\na furala bi furke\nLepe dekle moderne\nne padaju na žurke\n\nBrijem bradu, brkove\nda ličim na Pankrte\nJoš da imam Fendera —\nvidio bi svirke\n\nBalkane, Balkane, Balkane moj\nBudi mi silan i dobro mi stoj\n\nMi smo ljudi cigani\nsudbinom prokleti\nUvijek netko oko nas\ndođe pa nam prijeti\n\nNi bendovi nisu više\nkao što su bili\nMoj se amaterski\npriprema da svira\n\nBalkane, Balkane, Balkane moj\nBudi mi silan i dobro mi stoj	\N	\N	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
14	Bježi kišo s prozora	Crvena Jabuka	G	Brza	Pop / Rock	Hrvatska	Muško	Pada kiša napolju\nkaplje mi po prozoru\na ja sama kod kuće\nsjedim, plačem, tugujem\nne znam šta ću od sebe\n\nBježi kišo s' prozora\nbježi kišo s' prozora\nbježi kišo s' prozora\nda te nije sad bi' ja\nsvoga dragog ljubila\n\n\nKiša joj govorila\nkiša joj govorila\nsjedi curo kod kuće\njer on nije za tebe\non je sada kod druge\n\nsolo 2x\n\nTi si kišo lažljiva\nti si kišo lažljiva\nmene dragi ne vara\nja sam njemu najdraža\nbježi kišo s' prozora\n\nSolo outro 4x	\N	4	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
15	Bolja od najbolje	Ivan Zak	C	Srednja	Zabavno	Hrvatska	Muško	GIT Tema 1x\n\nDosta mi je ovih tvojih ludih prica\nda sam sinoc opet neku ljubio\nne zanima me sto se sad o meni prica\nako mi ne vjerujes, idi od mene\n\nRef.\nKad ti kazu da sam s nekom bio, lazu\njedina si ti za mene i uvijek ces ostati\na sve druge, sto su dio tvoje tuge\nza to nema potrebe, jer bolja si od najbolje\n\nGIT Tema 1x\n\nDosta mi je tvojih ludih pitanja\ns kim sam bio sinoc ja do svitanja\nne zanima me sto se sad o meni prica\nako mi ne vjerujes, idi od mene\n\nRef. 2x\n\nGIT Tema 1x - pa modulacija u Cis\n\nRef. 1x	\N	\N	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
16	Čarobno jutro	Nina Badrić	Dm	Spora	Balada	Hrvatska	Žensko	INTRO\nVER\nŠto je to, tako snažno da pogledaš\nMožda znak da si čovjek kojeg želim kraj sebe\n\nBRIDGE\nJedna iskra je dovoljna\nDa zapali vatru, da ispustim glas\nNježno ljubiš mi vrat\nKao stranac u noći, iz mog sna\n\nREF\nObećaj mi da, smo život ti i ja\nJedna olujna noć mokra sva od dodira\nU meni sve gori pod rukama tvojim\nJa umirem sad\nObećaj mi da, smo snaga valova\nPodivljali žar, na vrelim usnama\nTo čarobno jutro u očima mojim\nKad tvoja sam sva\n\nBRIDGE 2\nPrije tebe tuge su me stoput slomile\nVoljela sam druge, u njima tražila sam te\nNe daj me, više nikad nikome\nCijeli život čekam slomljenog srca\nDa suze mi obriseš sve\n\nREF\nObećaj mi da, smo život ti i ja\nJedna olujna noć mokra sva od dodira\nU meni sve gori pod rukama tvojim\nJa umirem sad\nObećaj mi da, smo snaga valova\nPodivljali žar, na vrelim usnama\nTo čarobno jutro u očima mojim\nKad tvoja sam sva	\N	\N	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
17	Činim pravu stvar	Gibonni	G	Srednja	Pop / Rock	Dalmacija	Muško	INTRO tema GIT\n\nVER:\nMozda i dogodi se cudo\ni onda uspijem presutjeti\nteske rijeci i sve grubo\nsve sto ljudi govore\nkad se vise ne vole\n\nMozda se jednom rodi nada\ni onda uspijem ti priznati\nda si najbolja do sada\nda sa tobom nijedna\nne moze se mjeriti\n\nBRIDGE:\nNema pravila, tu nema pameti\nkad nastupi tisina\nmi smo dvoje ljudi\nsto se ne mogu razumjeti\n\nRef.\nI cinim pravu stvar\nne spominjem te ja\njezik pregrizem\nda ne bih opsovao\nda ne bih opsovao\novaj zivot\nsto ga dijelim na pola\n\nI kada pozelim te ja\njezik pregrizem\nda ne bih opsovao\nda ne bih opsovao\novaj zivot sto ga\ndijelim na pola\n\nSOLO\n\nSto je moje, sto je tvoje\nja tako ne mogu razmisljati\nsve smo gradili u dvoje\ni sve iz temelja\nsad cemo podijeliti\nkome noc, a kome dan\n\nNe, tu nema pameti\nkad nastupi tisina\nmi smo dvoje ljudi\nsto se ne mogu razumjeti\n\nRef.	\N	\N	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
18	Da je sreće bilo	Željko Bebek	C	Srednja	Zabavno	Hrvatska	Muško	Intro 2x\n\nMeni je Bog dao\nda sad poslije svega\ngledam kako grlis\nkako ljubis njega\n\nMeni je Bog dao\nda mi dusa luta\npo zemaljskom paklu\ntu na kraju puta\n\nBRIDGE\nU dugim zimskim nocima\nkad vjetar nosi sjecanja\na ja se pitam jesi li\njesi li me ikad voljela\n\nRef. 2x\nA da je srece bilo\nti bi sa mnom spavala\na da je srece bilo\ndjecu bi mi rodila\n\nSOLO\n\nMeni je Bog dao\nda sad poslije svega\ngledam kako grlis\nkako ljubis njega\n\nMeni je Bog dao\nda mi dusa luta\npo zemaljskom paklu\ntu na kraju puta\n\nBRIDGE\nU dugim zimskim nocima\nkad vjetar nosi sjecanja\na ja se pitam jesi li\njesi li me ikad voljela\n\nRef.3x da je srece bilo\nti bi sa mnom spavala\na da je srece bilo\ndjecu bi mi rodila 3x	\N	\N	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
19	Da ti nisam bila dovoljna	E.T.	Cm	Srednja	Trash	Hrvatska	Žensko	TEMA Kljava.          Petko\nVER:\nUzalud gledam u tebe\nu tvojim ocima vidim nju\nsve sto govoris zvuci bezveze\ni znam da lazes i ovaj put\n\nI dodje mi da razbijem sve\ndodje mi da poludim zbog nje\ndodje mi da igram kao i ti\nda ti mogu pokazati\n\n\nRef.\nJa sada znam\nda ti nisam bila dovoljna\na ona se pravi nevina\ndrugom dala je sve\ntvoja nije ni bila\n\nI znam da ti nisam bila dovoljna\ni treba ti jos sto godina\nda vidis kako sam ja\nza tebe stvorena bila\n\nTEMA Kljava\n\nVER:\nUzalud gledam u tebe\nu tvojim ocima vidim nju\nsve sto govoris zvuci bezveze\ni znam da lazes i ovaj put\n\nI dodje mi da razbijem sve\ndodje mi da poludim zbog nje\ndodje mi da igram kao i ti\nda ti mogu pokazati\n\n\nRef.\nJa sada znam\nda ti nisam bila dovoljna\na ona se pravi nevina\ndrugom dala je sve\ntvoja nije ni bila\n\nI znam da ti nisam bila dovoljna\ni treba ti jos sto godina\nda vidis kako sam ja\nza tebe stvorena bila\n\nSolo\n\nRef. 2x	\N	\N	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
77	Pismo moja	Oliver Dragojević	D	Spora	Balada	Dalmacija	Muško	Pismo moja, iscidi san dušu u tebe\nI pustija te u svit zbog ljubavi moje, nesritne\nDa mi svitliš put dok tražin je\n\nSvu lipotu svita ja stavija san tu\nU ovu šaku riči u moju nevolju i sudbinu\nDa mi svitliš put dok tražin je\nJer ova duša dalje bez nje više ne može\n\nRef:    2x\n\nPismo moja, leti mi do nje\nI šapni joj riči najlipše\nDa još uvik nosim za nju\nPosrid srca živu ranu\nKoju samo ona ličit zna\nsolo gitara\n\nSvu lipotu svita …\n\nRef: 2x\n\nPismo moja	\N	\N	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
21	Dajem ti srce zemljo moja	Doris Dragović	Dm	Srednja	Domoljubne	Hrvatska	Žensko	INTRO Tema Kljava\n\nVER:\nPjevat' cu ti pjesmu, zemljo moja\nova ce ti pjesma reci sve\nrodila sam tebi sina isto k'o sto od davnina\nradjale su majke za tebe\n\nReci cu mu jednom kad poraste\nto je tvoja zemlja i tvoj dom\nmodro more, maslinici, zlatno klasje u ravnici\nbit' ce uvijek tu u oku tvom\n\n\nRef.\nDajem ti srce, zemljo moja\ni bit' cu s tobom u dobru i u zlu\ni nema sile da mi te uzme\nja bit' cu s tobom, ostat' cu tu\n\nDajem ti zivot, zemljo moja\ni bit' cu s tobom u dobru i u zlu\npodijelit' s tobom srecu i tugu\nBog neka cuva moju Hrvatsku\n\nTEMA Kljava\n\nUsne moje krunicu dok mole\nnasi stari odlaze na put\ndok sa crkve zvona zvone, igraju se djeca nova\nsto za nama ostati ce tu\n\nRef.\nDajem ti srce, zemljo moja\ni bit' cu s tobom u dobru i u zlu\ni nema sile da mi te uzme\nja bit' cu s tobom, ostat' cu tu\n\nDajem ti zivot, zemljo moja\ni bit' cu s tobom u dobru i u zlu\npodijelit' s tobom srecu i tugu\nBog neka cuva moju Hrvatsku	\N	\N	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
22	Danas sam luda	Josipa Lisac	Hm	Srednja	Pop / Rock	Hrvatska	Žensko	REF\nDanas sam luda, ne znam što hoću\nDanas sam luda, želim samoću\n\nSutra ću opet znati sve što treba\nBit ću slatka, bit ću nježna\nSutra ću opet voljeti sve ljude\nDat ću opet sve za druge\n\nNe govori ništa više\nNe, ne pričaj mi sve te priče\nNe znam što bih, ne znam\nGdje sam, opasna sam\n\nREF\nDanas sam luda, ne znam što hoću\nDanas sam luda, želim samoću\n\nRazbiru me neke čudne stvari\nPun je mjesec, zbrka u glavi\nAl’ sutra ću opet biti ona stara\nMalo tužna, ali snažna\n\nBit ću opet ja uz tebe\nVoljeti ću opet sebe\nBit ću tvoja, bit će bolje\nSamo pusti da me prođe\nSee upcoming pop shows\nGet tickets for your favorite artists\nYou might also like\nNeću\nTijana Dapčević\nBitanga i princeza\nBijelo dugme\nLuka Silni\nLuka Silni\nREF\nDanas sam luda, ne znam što hoću\nDanas sam luda, želim samoću (x2)\n\nNe govori ništa više\nNe, ne pričaj mi sve te priče\nNe znam što bih, ne znam gdje sam\nOpasna sam, već sam bijesna\n\nREF\nDanas sam luda, ne znam što hoću\nDanas sam luda, želim samoću (x2)\n\nNe proganjaj me više\nNe znam što bih dala\nNe proganjaj me više\nDaj pusti me da spavam\nDaj pusti me da sanjam\n\nREF\nDanas sam luda, ne znam što hoću\nDanas sam luda, želim samoću (x4)	\N	\N	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
23	Dancing in the Moonlight	Toploader	Fm	Srednja	Pop / Rock	\N	Žensko	[Verse 1]\nWe get it on most every night\nWhen that moon is big and bright\nIt's a supernatural delight\nEverybody's dancing in the moonlight\n\n[Verse 2]\nEverybody here is out of sight\nThey don't bark and they don't bite\nThey keep things loose, they keep 'em tight\nEverybody's dancing in the moonlight\n\n[Chorus]\nDancing in the moonlight\nEverybody's feelin' warm and bright\nIt's such a fine and natural sight\nEverybody's dancing in the moonlight\n\n[Verse 3]\nWe like our fun and we never fight\nYou can't dance and stay uptight\nIt's a supernatural delight\nEverybody was dancing in the moonlight\n\n[Chorus]\nDancing in the moonlight\nEverybody's feelin' warm and bright\nIt's such a fine and natural sight\nEverybody's dancing in the moonlight\n\nSolo orgulje\n\n[Verse 1]\nWe get in almost every night\nWhen that moon is big and bright\nIt's a supernatural delight\nEverybody's dancing in the moonlight\n\n[Chorus]\nDancing in the moonlight …..\n\n\n\n\n\n\n\nDancing in the moonlight … drugi put samo ritam\n\n\n\n\n\n\n\nDancing in the moonlight  … 2x	\N	\N	Strano	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
24	Digni me visoko	Aerodrom	A	Srednja	Zabavno	Ex-Yu	Muško	Uzmi me sa sobom i odvedi me\ni odvedi me, i odvedi me\ndigni me visoko da ti ispricam\nsvoje snove sve, svoje snove sve\n\nO zemlji preko mora gdje su djevojke\ngdje su djevojke, gdje su djevojke\nkoje nikad nikom nisu rekle ne\nnisu rekle ne, nisu rekle ne\n\n\nRef.\nAl' ja ipak nisam luda\nkoja vjeruje u cuda\nsto se kriju iza mora\ni gora dalekih\n\nSpusti me na zemlju, ali oprezno\nali oprezno, ali oprezno\nhrabar sam, al' necu izazivat' zlo\nizazivat' zlo, izazivat' zlo\n\nMozda jednog dana ipak uspijem\nipak uspijem, ipak uspijem\nsamo ako prije se ne napijem\nse ne napijem, se ne napijem\n\nJer ja ipak nisam luda\nkoja vjeruje u cuda\nsto se kriju iza mora\ni gora dalekih\n\nFuckanje\n\nJer ja ipak nisam luda...\n\nLa la 3x\n\nJer ja ipak nisam luda...	4	1	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
25	Zakuni se ljubavi	Srebrna Krila	G	Srednja	Zabavno	Ex-Yu	Muško	Zakuni se ljubavi na ramenu mom\nzakuni se ljubavi u trenutku tom\nzakuni se ljubavi da moja si sva\nda sanjas ljubavi sve sto sanjam ja\n\nRef.\nAko trazis mir uz mene ga nadji\novaj ludi plam u meni ti ugasi\nduge jeseni nek prolaze kraj nas\nja u tebi moram naci spas\n\n\nZakuni se ljubavi na ramenu mom\ni proslost zaboravi u trenutku tom\nzakuni se ljubavi i ne budi zla\nzakuni se ljubavi da volis kao ja\n\nRef.\n\nZakuni se ljubavi na ramenu mom\nzakuni se ljubavi u trenutku tom	4	2	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
26	Dio tebe	Nola	A	Srednja	Pop / Rock	Hrvatska	Žensko	RIFF Gitara\n\nVER:\nGrad je danas tako pust\ngrad je danas tako siv\ntebe nema, pred tobom je put\nkilometre brojim kao i ti\n\nTvoje ruke osjecam\ntvoje usne jos me ljube\ni sutra bit ces tu, znam te\ni biti moj, i biti moj, biti moj\n\n\nRef.\nMiris tebe ja nosim\ndio tebe ja zelim biti\nkao sapat koji cujes rado\ndio tebe\n\nRIFF Git\n\nVER:\nVjerujem da me cuje\ni molim da te pazi\nput ti treba, put te nosi\nbas kao srce, kriz i sidro\n\nI sutra bit ces tu, znam te\ni biti moj, i biti moj, biti moj\n\nRef. 2x\n\nKao sapat koji cujes rado\ndio tebe	\N	\N	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
27	Ditelina s 4 lista	Dalmatino	A	Srednja	Zabavno	Dalmacija	Muško	Na mom srcu, jedina\nStoji piz od vrimena\nStoji krik od galeba\nI za tobon potriba\n\nPriko mora duboka\nPlovija san od oka\nDugo san te tražija, dušu san iscidija\nVeć san i posidija\n\nA ja san iz oka zalija\nAh-ah, draču ispod maslina\nA ja znan da tamo rasteš ti\nTi si ka ditelina s četri lista\nZa te uvik ima mista, dobrodošla mi\nMoja srića, to si ti\n\nNa mom dlanu crte dvi\nŽivota i jubavi\nPrva mi je preduga\nTo me nije ni briga\n\nA ona druga malena\nPuno mi je važnija\nNemoj me rastužiti, provaj je produžiti\nJer to možeš samo ti\n\nA ja san iz oka zalija\nAh-ah, draču ispod maslina\nA ja znan da tamo rasteš ti\nTi si ka ditelina s četri lista\nZa te uvik ima mista, dobrodošla mi\nMoja srića, to si ti\n\nA ja san iz oka zalija\nAh-ah, draču ispod maslina\nA ja znan da tamo rasteš ti\nTi si ka ditelina s četri lista\nZa te uvik ima mista, dobrodošla mi\nMoja srića, to si ti\nMoja srića, to si ti\nMoja srića, to si ti\nMoja srića, to si ti	\N	\N	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
28	Dođi	Parni Valjak	Em	Srednja	Pop / Rock	Ex-Yu	Muško	INTRO Kljava\n\nVER(#Mata i Kljava)\nDođi, zaboravi, nudim ti noći čarobne\nI buđenja u postelji punoj šećera\nIspred mog prozora drvo divljeg kestena\nPuno plodova koje nitko ne treba\n(#svi)\nAnđeli nek te čuvaju kada vrijeme oboli\nDa li čovjek sve, baš sve na kraju preboli\n\nREF:\nZaspao bih sada ja na tvojim rukama\nBudio se ne bih nikada\nNeka vrijeme samo broji svoje godine\nMeni je već dosta čekanja\n\nVER:\nDođi, zaboravi, nudim ti noći čarobne\nI buđenja u postelji punoj šećera\nDođi i ostani, nudim ti suze ko bisere\nMoje namjerе još su uvijek iskrene\n\nREF:\nZaspao bih sada ja na tvojim rukama\nBudio sе ne bih nikada\nNeka vrijeme samo broji svoje godine\nMeni je već dosta čekanja\n\nSOLO Git\nREF:\nZaspao bih sada ja na tvojim rukama (# kljava i Mata)\nBudio se ne bih nikada (#svi na sinkopu)\nNeka vrijeme samo broji svoje godine\nMeni je već dosta čekanja\n\nZaspao bih sada ja na tvojim rukama\nBudio se ne bih nikada\nNeka vrijeme samo broji svoje godine\nMeni je već dosta čekanja	\N	\N	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
29	Dok je tebe	Parni Valjak	C	Srednja	Pop / Rock	Ex-Yu	Duet	VERS LIDIJA:\n\nDotakni mi usne, probudi mi tijelo\njoš je vatre ostalo\ndotakni mi dušu, srce je vrelo\nza tebe je gorjelo\n\nRef LIDIJA\nI samo ne daj nikada\nda nam ljubav bude navika\ni samo ne daj, ne daj nikada\nda nam ljubav bude navika\n\n\nVERS MATA:\n\nSlušam, čujem, gledam i vidim\notvaraš se kao cvijet\ntvoje mi oči kažu što želim\nu njima leži sav moj svijet\n\nRef. Zajedno: 1x\n\nMATA: Probudi me strah, ne bih da te izgubim\nLIDIJA: samo ne znam kakve veze imaju godine sa tim\nZAJEDNO: idem dalje ja sa tobom zajedno\n                  dok je tebe ništa drugo nije potrebno\n\nsolo orgulje\n\n\nRef. Zajedno:   2x\n\nuuu\n\nne daj, ne daj nikada	\N	\N	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
30	Dolje na koljena	Vesna Pisarović	D	Srednja	Pop / Rock	Hrvatska	Žensko	INTRO Kljava\n\nVER:\nJos se sjecam one noci\nkad si rek'o odlazim\nsad me gledas, kumis, molis\nzelis da ti oprostim\n\nI pravis se fin\ni pravis se fin\nkad dobro znas da si kriv\n\nSlana rijeka pere lice\nsuza suzu sustize\nja te gledam, pa mi zao\nmeni tlak se podize\n\nI pravis se fin\ni pravis se fin\nkad dobro znas da si kriv\na sad si tu, al' briga me\n\nRef. 2x\nDolje na koljena\nreci mi moja voljena\ndolje na koljena\nako sam tvoja voljena\n\nVER:\nSto me tako blijedo gledas\nnisam ja pogrijesila\ntuzna bila, vise nisam\nnajgore prezivjela\n\nSad pravis se fin\ni pravis se fin\nkad dobro znas da si kriv\n\nI pravis se fin\nsad pravis se fin\nkad dobro znas da si kriv\na sad si tu, al' briga me\n\nRef. 2x\n\nVER(jazzy var.):\nDaj se sjeti, izgledas mi umorno\ndaj se sjeti, nije te pomladilo\ndaj se sjeti, molis da ti oprostim\nma zar te nije stid\n\nRef. 3x\n\nDolje na koljena	\N	\N	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
31	Dont stop me now	Queen	D	Srednja	Pop / Rock	\N	Muško	Tonight\nI'm gonna have myself a real good time\nI feel alive\nAnd the world, I'll turn it inside out, yeah\nI'm floating around in ecstasy, so\n\nDon't stop me now\nDon't stop me\n'Cause I'm having a good time, having a good time\n\nI'm a shooting star leaping through the sky like a tiger\nDefying the laws of gravity\nI'm a racing car, passing by like Lady Godiva\nI'm gonna go, go, go, there's no stopping me\n\nI'm burnin' through the sky, yeah\n200 degrees, that's why they call me Mister Fahrenheit\nI'm travelling at the speed of light\nI wanna make a supersonic man out of you\n\nDon't stop me now\nI'm having such a good time\nI'm having a ball\nDon't stop me now\nIf you wanna have a good time\nJust give me a call\n\nDon't stop me now\n'Cause I'm having a good time\nDon't stop me now\nYes, I'm havin' a good time\nI don't wanna stop at all, yeah\n\nI'm a rocket ship on my way to Mars on a collision course\nI am a satellite, I'm out of control\nI'm a sex machine ready to reload like an atom bomb\nAbout to whoa-oh, whoa-oh, oh, explode\n\nI'm burnin' through the sky, yeah\n200 degrees, that's why they call me Mister Fahrenheit\nI'm travelling at the speed of light\nI wanna make a supersonic woman of you\n\nDon't stop me, don't stop me, don't stop me\nHey-hey-hey\n(Don't stop me, don't stop me, ooh-ooh-ooh) I like it\n(Don't stop me, don't stop me) have a good time, good time\n(Don't stop me, don't stop me) oh\nLet loose, honey, alright\n\nGitara solo\n\nOh, I'm burnin' through the sky, yeah\n200 degrees, that's why they call me Mister Fahrenheit, hey\nI'm travelling at the speed of light\nI wanna make a supersonic man out of you (hey, hey)\n\nDon't stop me now\nI'm having such a good time\nI'm having a ball\nDon't stop me now\nIf you wanna have a good time (ooh, alright)\nJust give me a call\n\nDon't stop me now\n'Cause I'm having a good time\nDon't stop me now\nYes, I'm havin' a good time\nI don't wanna stop at all\n\nAh, da-da-da-da-da-da-ah-ah\nAh-da-da, ah-ah-ah\nAh, da-da, da-da-da-da-ah-ah\nOoh, ooh-ooh, ooh-ooh	\N	\N	Strano	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
32	Driving home for Christmas	Chris Rea	Amai7	Spora	Jazzy	\N	Muško	Intro 2x\n\nverse\nI′m driving home for Christmas\nOh, I can't wait to see those faces\nI′m driving home for Christmas, yeah\nWell, I'm moving down that line\n\nAnd it's been so long\nBut I will be there\nI sing this song\nTo pass the time away\nDriving in my car\nDriving home for Christmas\nIt′s gonna take some time, but I′ll get there\n\nTop to toe in tailbacks\nOh, I got red lights all around\nBut soon there'll be a freeway, yeah\nGet my feet on holy ground\n\nchorus\nSo I sing for you\nThough you can′t hear me\nWhen I get through\nAnd feel you near me\nDriving in my car\nI'm driving home for Christmas\n\nverse\nDriving home for Christmas\nWith a thousand memories\nI take a look at the driver next to me\nHe′s just the same\nJust the same\n\nTop to toe in tailbacks\nOh, I got red lights all around\nI'm driving home for Christmas, yeah\nGet my feet on holy ground\n\nchorus\nSo I sing for you\nThough you can′t hear me\nWhen I get through\nOh and feel you near me\nDriving in my car\nDriving home for Christmas\n\noutro\nDriving home for Christmas\nWith a thousand memories\nI take look at the driver next to me\nHe's just the same\nHe's driving home, driving home	\N	\N	Strano	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
33	Every breath you take	The Police	G9	Srednja	Balada	\N	Muško	Every breath you take\nEvery move you make\nEvery bond you break\nEvery step you take\nI'll be watching you.\n\nEvery single day\nEvery word you say\nEvery game you play\nEvery night you stay\nI'll be watching you.\n\nOh can't you see\nYou belong to me?\nHow my poor heart aches with every step you take.\n\nEvery move you make\nEvery vow you break\nEvery smile you fake\nEvery claim you stake\nI'll be watching you.\n\nbridge:\n\nSince you've gone I've been lost without a trace.\nI dream at night, I can only see your face.\nI look around but it's you I can't replace.\nI feel so cold, and I long for your embrace.\nI keep crying baby, baby, please...\n\nOh can't you see\nYou belong to me?\nHow my poor heart aches with every step you take.\n\nEvery move you make\nEvery vow you break\nEvery smile you fake\nEvery claim you stake\nI'll be watching you\nEvery move you make\nEvery step you take\nI'll be watching you\n\nhook\n\n               I'll be watching you\n\nEvery breath you take, every move you make, every bond you break ,every step you take\n\n               I′ll be watching you\n\nEvery single day, every word you say, every game you play, every night you stay\n\n                I'll be watching you\n\nEvery move you make, every vow you break, every smile you fake, every claim you stake\n\n               I'll be watching you\n\nEvery single day ….\n\n               I′ll be watching you\n\nEvery breath you take  …	\N	\N	Strano	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
78	Prijatelji	Marko Perković Thompson	Am	Srednja	Domoljubne	Hrvatska	Muško	Prijatelji, cesto mislim na vas\nnije ovo vrijeme dobro za nas\nnisu cure sto su bile\nsve su se u gradu skrile\nprijatelji, kako ste mi danas\n\nSjetite se na ponosne dane\nkada jedan uz drugoga stane\nsve smo mogli, sve smo smjeli\ni bili smo sto smo htjeli\nprijatelji, kako ste mi danas\n\nRef.\nKazite mi, jeste li se umorili\njesu li vas prevarili\nje l' nas vrijeme pregazilo\nkazite mi, pjevate li pjesme stare\nkao nekad uzdignute glave\nda l' ste isti kao nekada\nprijatelji, cesto mislim na vas\n\nRado bih vas sve vidio zdrave\nsamo da nas opet skupa stave\npa da ko na prvoj crti\nzapjevamo protiv smrti\nprijatelji, kako ste mi danas\n\nRef.	\N	\N	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
35	Frida	Psihomodo Pop	C	Srednja	Pop / Rock	Hrvatska	Muško	INTRO\n\nREF:\nFrida je bila moja kraljica [3x]\nali nitko nije bio njezin kralj\n\nVER:\nJa sam radio\na ona je cekala\nona je cekala\nda padne mrak\n\nOna se cudila\nsto ne znam uzivati\nja sam joj rekao\nhey honey nije to sam tak'\n\nBREAK:\nPod nama su\npucali kreveti\nmi smo se pucali\ndok ne pukne dan\n\nVER:\nJa sam je gadjao\nal' nisam pogodio\ntaj joj metak\nnije dovoljan\n\nFrida ja ti nisam dida\nimas dobre usi slusaj kroz njih\nti si bila moja jedina pracka\na ja sam bio samo sprih\n\nREF:\nFrida je bila moja kraljica\nFrida, jesi l' cula za Lou Reeda\nFrida je bila moja kraljica\nali nitko nije bio njezin kralj	\N	\N	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
36	Fritula	Petar Grašo	Fis	Srednja	Zabavno	Dalmacija	Muško	Kasna svirka, rani let\nIden doma, dan je svet\nAerodrom ka i svi\nJingle bells i ukrasi\nDi baš sad, di baš sad\nDa na Badnjak budem tu,\nMoji svi, moji svi\nOko stola čekaju\n\nref:\nSve bi da, da za nju\nJednu malu fritulu\nI da te i da me\nDržiš čvrsto za ruku\nJer ja sanjam taj Badnjak uz tebe\nSve bi da, da za nju\nJednu malu fritulu\nI da te, i da me\nDržiš čvrsto za ruku\nJer ja sanjam\nDa u ponoć šapnem ti\nSretan Božić ljubavi\n\nSolo1 krug\n\nA na broju 325 piše otkazani let\nJa trčim, tražim rent – a – car\nDa se spasi cila stvar\nDi baš sad, di baš sad\nDa na Badnjak budem tu\nMoji svi, moji svi\nOko stola čekaju\n \nRef:\nSve bi da, da za nju . . .\nLjubaviiii..\n\nJa sve bi daaaaaa\nI da te i da me\nDržiš čvrsto za ruku\nJer ja sanjam da\nU ponoć šapnem ti\nSretan Božić ljubavi\nSretan Božić ljubavi	\N	\N	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
37	Geni Kameni	Marko Perković Thompson	C	Srednja	Domoljubne	Hrvatska	Muško	Čvrsta ruka i poštenje\nSveta voda i krštenje\nBudi čovik to je dika\nBudi roda svoga slika\n\nNe daj na se, ne daj svoje\nNemoj tuđe, prokleto je\nJer ko život tako prođe\nPonosan pred Boga dođe\nGdje god da te život nosi\nUvik moraš znati 'ko si, hej\n\nGeni, geni kameni\nVatra gori u meni\nGeni, geni kameni\nTakvi smo mi rođeni\nGeni, geni kameni\nVatra gori u meni\nGeni, geni kameni\nTakvi smo mi rođeni\nUzmi ili ostavi\nInstrumental\n\nLoša bila 45ta\nRasula nas preko svijeta\nA sad nova loza raste\nVratile se kući laste\n\nPlave krvi, bijelog lica\nRađaju se nova dica\nNa kamenu ka na svili\nDi oduvik mi smo bili\nGdje god da te život nosi\nUvik moraš znati ko si, hej\n\nGeni, geni kameni\nVatra gori u meni\nGeni, geni kameni\nTakvi smo mi rođeni\nGeni, geni kameni\nVatra gori u meni\nGeni, geni kameni\nTakvi smo mi rođeni\nGeni kameni\nPrijelaz u sto na nebu\n\nŠto na nebu sja visoko\nŠto na nebu sja visoko\nMjesec je il' sivi soko\nMjesec je il' sivi soko\n\nŠto na nebu sja visoko\nŠto na nebu sja visoko\nMjesec je il' sivi soko\nMjesec je il' sivi soko\n\nŠto na nebu sja visoko\nŠto na nebu sja visoko\nMjesec je il' sivi soko\nMjesec je il' sivi soko\n\nŠto na nebu sja visoko\nŠto na nebu sja visoko\nMjesec je il' sivi soko\nMjesec je il' sivi soko\n\nŠto na nebu sja visoko\nŠto na nebu sja visoko\nMjesec je il' sivi soko\nMjesec je il' sivi soko\n\nGeni, geni kameni\nVatra gori u meni\nGeni, geni kameni\nTakvi smo mi rođeni\nGeni, geni kameni\nVatra gori u meni\nGeni, geni kameni\nTakvi smo mi rođeni\nGeni kameni	\N	\N	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
39	Gutljaj vina	Magazin	D	Srednja	Zabavno	Hrvatska	Žensko	INTRO GIT\n\nVER:\nStara ljubavi ti\nmozda sjetis se mene\novu noc il' sutradan, tko zna\nmozda zavrtis film devedeset i neke\ndoba kad su ljubav i rat\nna srcu pomakli sat\na, gdje si mi sad\n\nREF: [2x]\n/Kad/Da/treba mi gutljaj vina\nda mi pravi drustvo, skrati noc\nja znam\nda volim te od davnina\ni da necu, necu priznat' to\n\nVER:\nGodine ove sve\nod tebe se ne trijeznim\nsamo film prebacim, na tren\nsrecu poznajem tek onda\nkad se nas sjetim, da bar\nkad su ljubav i rat\nna srcu pomakli sat\na gdje si mi sad\n\nREF: [4x]\n/Kad/Da/treba mi gutljaj vina\nda mi pravi drustvo, skrati noc\nja znam\nda volim te od davnina\ni da necu, necu priznat' to	\N	\N	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
38	Get Lucky	Daft Punk	Hm	Srednja	Funky	\N	Muško	INTRO - Koncertna tema (distorzija) na Gitari 2x\r\n\r\nLike the legend of the phoenix\r\nAll ends with beginnings\r\nWhat keeps the planet spinning\r\nThe force from the beginning (huh, look)\r\n\r\nWe've come too far\r\nTo give up who WE re\r\nSo let's raise the bar\r\nAnd our cups to the stars\r\n\r\nShe's up all night 'til the sun\r\nI'm up all night to get some\r\nShe's up all night for good fun\r\nI'm up all night to get lucky\r\n\r\nWe're up all night 'til the sun\r\nWe're up all night to get some\r\nWe're up all night for good fun\r\nWe're up all night to get lucky\r\n\r\nWe're up all night to get lucky\r\nWe're up all night to get lucky\r\nWe're up all night to get lucky\r\nWe're up all night to get lucky\r\n\r\nThe present has no ribbon\r\nYour gift keeps on giving\r\nWhat is this I'm feeling?\r\nIf you wanna leave, I'm with it, ah\r\n\r\nWe've come too far\r\nTo give up who we are\r\nSo, let's raise the bar\r\nAnd our cups to the stars\r\n\r\nShe's up all night 'til the sun\r\nI'm up all night to get some\r\nShe's up all night for good fun\r\nI'm up all night to get lucky\r\n\r\nWe're up all night 'til the sun  (samo gitara i klap)\r\nWe're up all night to get some\r\nWe're up all night for good fun\r\nWe're up all night to get lucky\r\n\r\nWe're up all night to get lucky (samo gitara i klap)\r\nWe're up all night to get lucky\r\nWe're up all night to get lucky\r\nWe're up all night to get lucky\r\nrobotski\r\nWe've come too far\r\nTo give up who we are\r\nSo let's raise the bar\r\nAnd our cups to the stars\r\n\r\nShe's up all night 'til the sun\r\nI'm up all night to get some\r\nShe's up all night for good fun\r\nI'm up all night to get lucky\r\n\r\nWe're up all night 'til the sun\r\nWe're up all night to get some\r\nWe're up all night for good fun\r\nWe're up all night to get lucky\r\n\r\nWe're up all night to get lucky\r\nWe're up all night to get lucky\r\nWe're up all night to get lucky\r\nWe're up all night to get lucky\r\n\r\nWe're up all night to get lucky\r\nWe're up all night to get lucky\r\nWe're up all night to get lucky\r\nWe're up all night to get lucky\r\n\r\nKraj	\N	\N	Strano		0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
40	Hajde da ludujemo	Tajči	D	Srednja	Zabavno	Ex-Yu	Žensko	RIFF GIT\n\nVER:\nNe moras biti bogat i lijep\nsamo budi dobar i pokloni mi cvijet\nne moras biti snazan i grub\nda budes sav moj svijet\n\nTi si momak za pobjede\ndvije prave rijeci bit' ce dovoljne\nplava zvijezda na nebu sja\nti si onaj koji tajnu zna\n\nREF:[2x]\nHajde da ludujemo ove noci\nhajde zaljubi se u moje oci\ntvoje su usne kao cokolada\nto mi se dopada\n\nRIFF GIT\n\nVER:\nNe moras biti bogat i lijep\nsamo budi dobar i pokloni mi cvijet\nne moras biti snazan i grub\nda budes sav moj svijet\n\nTi si momak za pobjede\ndvije prave rijeci bit' ce dovoljne\nplava zvijezda na nebu sja\nti si onaj koji tajnu zna\n\nREF:[2x]\nHajde da ludujemo ove noci\nhajde zaljubi se u moje oci\ntvoje su usne kao cokolada\nto mi se dopada\n\nSOLO GIT [Hm]\nModulacija D♯\n\nREF:[2x]\nHajde da ludujemo ove noci\nhajde zaljubi se u moje oci\ntvoje su usne kao cokolada\nto mi se dopada	\N	\N	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
41	Ja sam lažljiva	Denis & Denis	D	Srednja	Zabavno	Ex-Yu	Žensko	INTRO\n\nVER:\nZbog nekih lutaka koje sam voljela\nnocas te dozivam da me zabavljas\ndonesi oblake, nemirne korake\ncesljaj me satima i pricaj prstima\n\nZbog toplih jastuka gdje sam te sakrila\nnocas zaboravljam da sam izgubila\ndonesi haljine, staklene lancice\nobuci mirise i mazi me\n\nREF:\nBas je dobro nocas sve je toplo\na ja sam lazljiva\nbudi dobar, nocas budi hrabar\njer ja sam lazljiva\n\nINTRO:\n\nVER:\nZbog nekih lutaka koje sam voljela\nnocas te dozivam da me zabavljas\ndonesi oblake, nemirne korake\ncesljaj me satima i pricaj prstima\n\nZbog toplih jastuka gdje sam te sakrila\nnocas zaboravljam da sam izgubila\ndonesi haljine, staklene lancice\nobuci mirise i mazi me\n\nREF: 1X\nINTRO\n\nREF:[4x] -prvi put samo s ritmom\nBas je dobro nocas sve je toplo\na ja sam lazljiva\nbudi dobar, nocas budi hrabar\njer ja sam lazljiva	\N	\N	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
42	Ja samo pjevam	Severina	Am	Srednja	Zabavno	Hrvatska	Žensko	INTRO:\n\nVER:\nTi si najljepsi od svih\nsvi drugi stanu u stih\ntebi ni pjesma nije dovoljna\neh, sto te ludo, ludo volim ja\n\nTi si moja mala ikona\npred kojom molim se ja\nnek lose krene i ne ide\nrazvucem osmjeh i briga me\n\nREF:[2x]\nJa samo pjevam, ja samo sviram\nja nemam razlog da se zivciram\njer imam tebe koji me ljubi\nkoji me voli kada zivot zaboli\n\nINTRO:\n\nVER:\nTi si najljepsi od svih\nsvi drugi stanu u stih\ntebi ni pjesma nije dovoljna\neh, sto te ludo, ludo volim ja\n\nREF:[2x]\nJa samo pjevam, ja samo sviram\nja nemam razlog da se zivciram\njer imam tebe koji me ljubi\nkoji me voli kada zivot zaboli	\N	\N	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
43	Juliška	Miroslav Škoro	Dm	Srednja	Tambure	Slavonija	Muško	INTRO:\n\nVER:\nKad se sjetim ja, moja Juliska\nkako si mene ljubila\nkako smo samo ludo plesali\ndok su cardas svirali\n\nREF:\nTvoje male slatke cizmice\nzemlju nisu dirale [naglasi spuštanje]\nnije bilo ljepse curice\nod tebe, golubice\n\nINTRO:\n\nVER:\nMeni cini se da su noci te\nzvijezde sve nama sijale\npokraj carde trava polegla\nnama pamet pobjegla\n\nREF:\nTvoje male slatke cizmice\nzemlju nisu dirale [naglasi spuštanje]\nnije bilo ljepse curice\nod tebe, golubice\n\nINTRO:\n\nVER:\nSamo Bog to zna, moja Juliska\ngdje si sad, u cijim snovima\nmeni dusa uvijek zaigra\nkada cardas zasvira\n\nREF:\nTvoje male slatke cizmice\nzemlju nisu dirale [naglasi spuštanje]\nnije bilo ljepse curice\nod tebe, golubice\n\nVER1\n\nRef.\n\nLa la laj.... 2x glasno\nLa la laj... 1x tiho\nLa la laj... 1x glasno	\N	\N	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
44	Kada žene tulumare	Jole	Fm	Srednja	Zabavno	Hrvatska	Muško	REF:\nKada zene tulumare\nnajbolje se trose pare\nkada zene tulumare\npjevaju se pjesme stare\n\nINTRO\n\nVER:\nPusti ritam neka krene\nza sve cure, za sve zene\nnek polude nek se raspamete\n\nNek se popnu na stolove\nnjisu bedra i bokove\nsvakom zivom razum poremete\n\nBRIDGE\nKad uzavre miris dima\nalkohola i parfema\nnema nazad pusti da te nosi\n\nZadnju paru spiskat cu\ncijele noci pjevat cu\nkad svi odu, zadnji ostat cu\n\nREF:\nKada zene tulumare\nnajbolje se troše pare\nkada zene tulumare\npjevaju se pjesme stare\n\nKad se zene napiju\npamet rusi kapiju\ntko ce nocas s kime zaspati\n\nJer su zene bekrije\nnajbolje musterije\nsve ih volim necu birati\nsa svakom se sretan probudim\n\nTEMA\n\nLudi tulum neka krene\nza sve cure za sve zene\nnek polude nek se raspamete\n\nBRIDGE, Ref.\n\nKad se zene napiju\npamet rusi kapiju\ntko ce nocas s kime zaspati\n\nJer su zene bekrije\nnajbolje musterije\nsve ih volim necu birati\nsa svakom se sretan probudim\n\nSamo Ref. 2x\n\nKraj	\N	\N	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
45	Kiše jesenje	Prljavo Kazalište	A	Srednja	Pop / Rock	Hrvatska	Muško	Kiše Jesenje – A – Prljavo Kazalište\n\nuvod klavir+gitara\n\nNoćas mladi mjesec je, dobra večer dame sve\nSpuštam se u barove\nDolje neki klinac na klaviru našu pjesmu svira\nŠto me grozno živcira\n\nMazni glas me pita imaš vilu iznad Zagreba\nIl' auto s tamnim staklima\n\nHej curo šećeru nemam ja za večeru\nZa malu votku, rakiju\nHej curo šećeru ja sam ptica nebeska\nI to je moja sudbina\n\nref:\nKroz moje prazne džepove\nVjetrovi me prolaze\nA kroz cipele kiše jesene\nKroz moje prazne džepove\nVjetrovi me prolaze\nA kroz cipele kise jesene\nO o o o o o o o o o ...\n\nNoćas mladi mjesec je, dobra večer dame sve\nSpuštam se u barove\nDolje neki klinac na klaviru nasu pjesmu svira\nSto me grozno živcira\n\nHej curo šećeru nemam ja za večeru\nZa malu votku, rakiju\nHej curo šećeru ja sam ptica nebeska\nI kao takav umrijet ću\n\nref:\nKroz moje prazne džepove …\n\nsolo klavir\n\nref:\nKroz moje prazne džepove …	\N	\N	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
46	Ko nam brani	Petar Grašo	A	Srednja	Zabavno	Hrvatska	Muško	VER1\nNekad cini mi se\nda je propalo sve\nnista nece da krene\nlose doslo je vrijeme\na ja ne vidim spas za nas\n\nZato bjezim od svih\nnekad napisem stih\nnekad odem do sanka\nal' je linija tanka\nizmedju jave i sna\nvrha i dna i pjevam\n\nRef. 2x\nHej, duso, 'ko nam brani\nda bude sve 'ko lani\nna moju dusu stani i ostani\n\nVER2\nCovjek pokvari sve\nprije il' kasnije\nljubav nije za ljude\nneka bude sta bude\nnecu pustit' ni glas za nas\n\nZato bjezim od svih\nnekad napisem stih\nnekad odem do sanka\nal' je linija tanka\nizmedju jave i sna\nvrha i dna i pjevam\n\nRef. 2x\n\nModulacija\n\nRef. 2x\n\nI na moju dušu stani (i ostani)	\N	\N	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
47	Kolačići	Marina Perazić	E	Srednja	Zabavno	Ex-Yu	Žensko	Kolačići-E - Marina Perazić\n\nGrad je tako siv i hladno je\na jutro me zadirkuje\nda sam blesava\nšto sam nervozna\njer ne znam gdje si sad\n\nKao rumeni kolačići\ndječaci hodaju po ulici\ni bas sam blesava\nšto sam nervozna\njer ne znam gdje si sad\n\nRef. 2x\nPojest' ću sve kolačiće\ntebi u inat postat' ću debela\nsve djevojke\nneće biti slatke kao ja\nneće biti slatke kao ja\n\nsolo gitara\n\nsve ponovno od početka..\n\n\nRef. 4x	\N	\N	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
48	Konoba	Meri Cetinić & Oliver	A	Srednja	Balada	Hrvatska	Duet	Meri Cetinić i Tedi Spalato\nKONOBA   A  (original iz H)\n\nLidija:\nImala si baril i bronzine\npod škancijon stivane bocune\nsve si gušte na ovome svitu\ndarivala ka lipe bokune\n\nmuško:\nVonjala si točon i friškinon\nladila me kad uvati fjaka\na kad dušu stegla bi tuga\nu tebi san i piva i plaka\n\nRef.\nKonobo moja, radosti sva\ndušu san svoju svu tebi da\nkonobo moja, ka dom si moj\nčuvan ti pismu ka život svoj\n\nna, na, na\n\n\n\nmodulacija\nLidija:\nUz šteriku jos vonja lavanda\nrazvodni se život ka bevanda\nod bibiti, falši novitadi\nne damo se, još smo uvik mladi\n\nmuško: \n'Ajmo skupa, prijatelji moji\nrazmistimo tamburin, katrige\nzapivajmo pismu s kojon srce\nu po žmula zaboravlja brige\n\nRef.\nKonobo moja. .. 2x	\N	\N	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
49	Krivo je more	Divlje Jagode	G	Spora	Balada	Hrvatska	Muško	VER:\nTi, ti si ga upoznala\nJedne ljetne večeri\nOn, on te poljubio\nDok more se pjenilo\n\nREF:\nI ti si se zaljubila\nMada nisi htjela to\nKrivo je more\n\nVER:\nZnaj, ljeto je varljivo\nA srce ti zavodljivo\nKući kad si došla ti\nZnala si da si u zabludi\n\nREF:\nA to veče uz mora šum\nOd sreće sva si blistala\nKrivo je more\n\nSOLO 2x\n\nVER:\nZnaj, ljeto je varljivo\nA srce ti zavodljivo\nKući kad si došla ti\nZnala si da si u zabludi\n\nREF:\nA to veče uz mora šum\nOd sreće sva si blistala\nKrivo je more\n\nSOLO 2x	\N	\N	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
52	Lay down Sally	Eric Clapton	A	Srednja	Pop / Rock	\N	Muško	INTRO GIT\n\nVER:\nThere is nothing that is wrong\nIn wanting you to stay here with me\nI know you've got somewhere to go\nBut won't you make yourself at home and stay with me?\nAnd don't you ever leave\n\nREF:\nLay down, Sally, and rest here in my arms\nDon't you think you want someone to talk to?\nLay down, Sally, no need to leave so soon\nI've been trying all night long just to talk to you\n\nVER:\nSun ain't nearly on the rise\nWe still got the moon and stars above\nUnderneath the velvet skies, love is all that matters\nWon't you stay with me?\nDon't you ever leave\n\nREF:\nLay down, Sally, and rest here in my arms\nDon't you think you want someone to talk to?\nLay down, Sally, no need to leave so soon\nI've been trying all night long just to talk to you\n\nSOLO GIT\n\nVER:\nI long to see the morning light\nColoring your face so dreamily\nSo don't you go and say goodbye\nYou can lay your worries down and stay with me\nDon't you ever leave\n\nREF:\nLay down, Sally, and rest here in my arms\nDon't you think you want someone to talk to?\nLay down, Sally, there's no need to leave so soon\nI've been trying all night long just to talk to you\nLay down, Sally, and rest here in my arms\nDon't you think you want someone to talk to?\nLay down, Sally, there's no need to leave so soon\nI've been trying all night long just to talk to you	\N	\N	Strano	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
53	Lutka	S.A.R.S	C	Srednja	Balada	Hrvatska	Muško	Uvod - violina sama 1 krug, svi 1 krug\n\nKo mi tebe uze\nKo mi tebe posla\nKo provocira nase suze\nSvaki put kad bi dosla\n\nMeni mozak brani\nDa se tebi predam\nTvoja pojava me hrani\nAl' se ipak ne dam\n\nI samo te gledam\nOsecaj je izvanredan\nI toj drogi bicu predan\nMakar ost'o cedan\n\nLutko, ja sam resen\nDa vecno s tobom plesem 2x\n\nPogled tvoj me srami\nAli strasno godi\nMiris tvoj me mami\nDodir tvoj me vodi\n\nTi si cilj mog lutanja\nI predmet pobude\nRazlog mog drhtanja\nBoja moje pozude\n\nI dok tonem u san\nU mraku cujem tvoj glas\nNa jastuku stiskam tvoj dlan\nOrkestar svira za nas\nRef.4x	\N	\N	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
54	Lutka za bal	Parni Valjak	A	Srednja	Pop / Rock	Ex-Yu	Duet	Sreo sam je prvi put u Stopoteci\nGore u Ljubljani dok trajao je Boom festival\nBacila je ruke oko moga vrata\nI rekla Aki, zar nismo dobar par?\n\nI zato …\n\n2x Ajde mala dodi u moju sobu\nImat ćemo privatan bal\nŠteta bi bila da propadne stvar\nKad kažeš da smo tako dobar par\n\nMa stoj, što ti misliš o meni\nDa sam ja mačka samo za jednu noć\n\nNe, al' ja sam samo još danas ovdje\nI tko zna kada, opet, moći ću doć'\n\nI zato mala kreni\n\nAjde mala dođi u moju sobu\nImat ćemo privatan bal\nŠteta bi bila da propadne stvar\nKad kažeš da smo tako dobar par\n\nAjde mala dođi u moju sobu\nImat ćemo privatan bal\nŠteta bi bila da propadne stvar\nKad kažeš da smo tako dobar par\n\nSolo git pa kljave\n\n2x Ajde mala dođi u moju sobu\nImat ćemo privatan bal\nŠteta bi bila da propadne stvar\nKad kažeš da smo tako dobar par	6	1	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
55	Ne zovi mama doktora	Prljavo Kazalište	A	Srednja	Pop / Rock	Hrvatska	Muško	Što sad ljubav\nMa, što sad ljubav ima s tim\nKad te više ne volim\nKad te više ne volim\nŠto sad ljubav\nMa, što sad ljubav ima s tim\nKad te više ne volim\nKad te više ne volim\n\nMa ne plačem, mama\nNe rade to muškarčine, o ne\nSve je to od dima\nMa kakve emocije\n\nI to što ne jedem, mama\nTo je stvar linije\n\nI sama znaš\nDa ne trpim savjete\n\nŠto sad ljubav\nMa, što sad ljubav ima s tim\nKad te više ne volim\nKad te više ne volim\n\nŠto sad ljubav\nMa, što sad ljubav ima s tim\nKad te više ne volim\nKad te više ne volim\n\nNe zovi mama, ne zovi doktora\nJer nema lijeka protiv tog otrova\nMa dobro mama\nPreboljet ću ja to\nSamo pusti nek' svira\nGlasno rock 'n' roll\n\nŠto sad ljubav\nMa, što sad ljubav ima s tim\nKad te više ne volim\nKad te više ne volim\n\nŠto sad ljubav\nMa, što sad ljubav ima s tim\nKad te više ne volim\nKad te više ne volim\n\nSolo\n\nŠto sad ljubav\nMa, što sad ljubav ima s tim\nKad te više ne volim\nKad te više ne volim\n\nŠto sad ljubav\nMa, što sad ljubav ima s tim\nKad te više ne volim\nKad te više ne volim\n\nUuu Ne zovi mama doktora 4x	6	2	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
57	Mađarica	Zdravko Čolić	Am	Srednja	Zabavno	Ex-Yu	Muško	Jos se nisam ni brijao\nzivot mi je vec prijao, prijao\nkad sam krenuo amidzi\nstarim drumom ka Ilidzi\n\nSreca il' cudo sta li je\nda je bogdo i ranije, ranije\nmase zove me curica\nkaze da je Madjarica\n\nRef.\nHajde, hajde reci\nziva bila otkud ovde\nhajde, bona\nslatka k'o bombona\n\nNisam ni ja od kamena\nkad se takla mog ramena, ramena\npitam mala u cem' je stvar\nkaze, trazim put za Mostar\n\nNe znam dal' se zaljubila\nkao divlja me ljubila\nkad sam krenuo amidzi\nstarim drumom ka Ilidzi\n\nRef. Pa samo:\n\nHajde, bona\nslatka k'o bombona\n\nRef. 2x\n\nKraj	\N	\N	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
58	Malo mi za sriću triba	Doris Dragović	C	Srednja	Balada	Dalmacija	Žensko	Lipi grozdi srca moga\nPuni vina njegovoga,\nA on neće doć' u jematvu.\n\nBokun mora, bokun neba;\nKamen cvita kad ga gleda,\nA di neću ja, di neću ja;\nNa me stavi kap jubavi.\n\nref:    \n\nMalo mi za sriću triba\nDa me zove moja lipa,\nDa mi kažu zlato moje\nLipe usne te njegove.\n \nVilo moja dalmatinska\nŽeja se u tilu stiska.\nBrez njega je duša suva\nKa' i maslina bez uja.\n\nmodulacija\n\nU traverši nebo ima,\nModre zvizde di će s njima;\nStavja ih u oči njegove.\nBokun mora, bokun neba …\n\n ref: 1x\n\nU-u-u-u!	\N	\N	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
59	Marina	Prljavo Kazalište	B	Srednja	Pop / Rock	Hrvatska	Muško	Uvod \n\nNa Božićno jutro, sneno i mutno\nU kaputu očevom\nMalčice prevelikom\nJa došao sam na njena vrata\nDa joj kažem baš da odlazim\n\nJer nitko nije znao sakrit suze ko Marina\nImala je oči boje vena\nBoje vena, boje Dinama\nU je, u je, je, je\nBoje vena, boje Dinama\nU je, u je, je, je\n\nA ja, ja ne mogu bez nje\nBože, Bože spasi me\nA ja, ja ne mogu bez nje\nBože, Bože spasi me\nUuuuuu ne mogu bez nje\nO, Bože, Bože spasi me\nA ja, ja ne mogu bez nje\nBože, Bože spasi me\n\nSolo gitara\n\nJer nitko nije znao sakrit suze ko Marina\nA molim vas lijepo, recite vi, kakve je oči imala\nImala je oči boje vena\nBoje vena, boje Dinama\nU je, u je, je, je\nBoje vena, boje Dinama\nU je, u je, je, je\n\nA ja, ja ne mogu bez nje\nBože, Bože spasi me\nA ja, ja ne mogu bez nje\nBože, Bože spasi me\n\nA ja, ja ne mogu bez nje\nBože, Bože spasi me\nA ja, ja ne mogu bez nje\nBože, Bože spasi me\n\nO, Bože, Bože spasi me\nO, Bože, Bože spasi me\nBože, Bože spasi me\nBože Bože spasi me	\N	\N	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
60	Mata	Miroslav Škoro	Dm	Brza	Tambure	Slavonija	Muško	Mata je rođen jedne nedilje\nČetrdeset neke godine\nOtac nije za njega ni znao\nS križnog puta kad se vratio\n\nŽivili tako skromno, al' ponosno\nU selu malom, pitomom, slavonskom\nSeoske babe nisu ga volile\nKad krene šorom navuku firange\n\nREF:\nA ja, k'o da ga vidim još i sad\nU kas vraća konje s pojila\nSelo priča, Matu ne briga\nSamo konje brže potjera\n\nOnda je došla devedeseta\nOtac reče sad il' nikada\nI Mata krenu k'o iz nekog sna\nBez igdi išta, al' srca velika\n\nTe su mu zime brata ubili\nSpalili selo, konje odveli\nOca su našli nakon mjesec, dva\nSlomila ga tuga velika\n\nREF:\nA ja, k'o da ga vidim još i sad\nU kas vraća konje s pojila\nSelo priča, Matu ne briga\nSamo konje brže potjera\nAjdeee\nSOLO\n\nBio sam s Matom prošle nedilje\nKod crkve, poslije mise jutarnje\nUz njega sin mu i djeca bratova\nPa di si Mata, kako je, pitam ga\n\nVeli mi sve će biti k'o ranije\nOpet će selo okitit' kapije\nSve ćemo vratit', al' jedno nikad ne\nUspomene što su nam nestale\n\nREF:\nA ja, k'o da ga vidim još i sad\nU kas vraća konje s pojila\nSelo priča, Matu ne briga\nSamo konje još brže potjera\nSelo priča, Matu ne briga\nSamo konje, ajde\n\nSOLO (ubrzavanje)	\N	\N	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
61	Moj mali je opasan	Tajči	D	Srednja	Zabavno	Ex-Yu	Žensko	Moj mali je opasan \nal' tako je drag\non je nemiran i nestašan\nk'o crni vrag\nJedna ruka, druga ruka\nispod haljine\ne, moj mali, tako ne ide\n\n1 Moj mali je opasan\n  kada je Mjesec mlad\n  moj mali je opasan\n  kada krene u grad\n\n2 On nosi jaknu sa nitnama\n  i pije pivo bez pjene\n  on nosi tugu u očima\n  a voli samo mene\nobje kitice ponoviti\n\nRef. 2x\n3 Volim ga dirati\n  i maziti i ljubiti\n  i svi mi kažu\n  glavu cu izgubiti\n\n1    …. a tako mi je drag\n\nsolo\n\n1     2    3   \n\n1     2\n\nmoj mali je opasan\n\na voli samo mene 3x	\N	\N	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
62	Mojoj majci	Prljavo Kazalište	C	Spora	Pop / Rock	Hrvatska	Muško	Uvod gitara\n\nU njenu sobu uđem tiho.\nTiho baš, na prstima.\nBojim se da ne zalupim glasno vratima,\nZaspala je zadnja ruža hrvatska.\n\nI tek sad kad je nema.\nTko će jutrom da me budi.\nI tek sad kad te nema dobro znam,\nTi si bila zadnja ruža hrvatska.\nref:\nRužo, moja ružice,\nSve sam suze isplak'o, noću zbog tebe.\nRužo, moja ružice,\nSve sam suze isplako\n\nsolo gitara\n\nI kako sad ovako sam.\nProtiv tuge i oluje.\nKad smo bili kao prsta dva,\nPrsta dva jedne ruke.\n\n ref:\nRužo, moja ružice …\n\n solo gitara\n\nref:\nRužo, moja ružice …	\N	\N	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
63	Morska vila	Daleka Obala	C	Spora	Pop / Rock	Dalmacija	Muško	GIT TEMA 2x\n\nKao da je morska vila, sve je moje snove ostvarila\nNa obalama vrele neprospavane noći\nKao da je dio plime, modro more šumi njeno ime\nI sklada tihe pjesme, pjesme o samoći\n\nPREDREF\nKao da je dio sna\nŠto me nosi zvijezdama\n\nREF\nI dok je ljubim, ona se pretvara da spava\nGrijana zlatnim suncem moje ljubavi\nI dok je ljubim, kao more njeno tijelo podrhtava\nPovedi me prostranstvima gdje svi pjevaju o ljubavi\n\nGIT TEMA 2x\n\nKao da je morska vila, sve je moje snove ostvarila\nNa obalama vrele neprospavane noći\nKao da je dio plime, modro more šumi njeno ime\nI sklada tihe pjesme, pjesme o samoći\n\nPREDREF\nKao da je dio sna\nŠto me nosi zvijezdama\n\nREF\nI dok je ljubim, ona se pretvara da spava\nGrijana zlatnim suncem moje ljubavi\nI dok je ljubim, kao more njeno tijelo podrhtava\nPovedi me prostranstvima gdje svi pjevaju o ljubavi\n\nGIT TEMA 4X i Pjevaju o ljubavi 4x	\N	\N	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
64	Morski vuk	Oliver Dragojević & Tony Cetinski	A	Brza	Funky	Hrvatska	Duet	Oliver: Godina ja imam, ne pitaj me za broj\nmožda smo vršnjaci\nja i pape tvoj\n\nToni: U malom prstu imam život\na mlad san još ka bili cvit\ni mada misliš da sam dobar\nja sam dobitnik\n\n\nOliver: I da nisi lipa, plavi anđele\nToni bilo bi mi lako tebi reci ne, ne, ne\n\nRef.\nOliver: I zato čuvaj me se, mala\njer ja sam stari morski vuk\ni zato dobro pazi, mala\nda ne bi stala mi na put\n\nToni: I zato čuvaj me se, mala\njer ja sam mladi morski vuk\ni zato dobro pazi, mala\njer ja sam gadan kad sam ljut\n\nOliver: Godina ja imam\nne pitaj me za broj\n\n\nToni: i to manje više\nka i momak tvoj\n\nO:   I da nisi lipa\nRef:\n\nsolo\n\nspor si ka pas\n\ni da nisi lipa….\n\nRef: ….	\N	\N	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
65	Neh Nah Nah	Vaya Con Dios	Fism	Brza	Pop / Rock	\N	Žensko	I got on the phone and called the girls, said\nMeet me down at Curly Pearls, for a\nNey, Nah Neh Nah\nIn my high-heeled shoes and fancy fads\nI ran down the stairs hailed me a cab, going\n\nNey, Nah Neh Nah\n\nWhen I pushed the door, I saw Eleanor\nAnd Mary-Lou swinging on the floor, going\nNey, Nah Neh Nah\nSue came in, in a silk sarong\nShe walzed across as they played that song,\nGoing\n\nNey, Nah Neh Nah\n\nsolo guitar\n\nAnnie was a little late\nShe had to get out of a date with a\nNey, Nah Neh Nah\nCurly fixed another drink\nAs the piano man began to sing that song\n\nNey, Nah Neh Nah\n\nIt was already half past three\nBut the night was young and so were we,\nDancing\nNey, Nah Neh Nah\nOh Lord, did we have a ball\nStill singing, walking down that hall, that\n\nNey, Nah Neh Nah	\N	\N	Strano	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
66	Ne spavaj mala moja	Bijelo Dugme	A	Srednja	Pop / Rock	Ex-Yu	Muško	VER1\nNe spavaj mala moja\nMuzika dok svira\nJer taj ludi ritam nikom ne\nDa mira\n\nTvoja mama je legla i odavno\nSpava\nNiko nece znati da si bila\nS' nama\nCekacu te jos trenutak mala\nMoja\n\nOnda odoh plesat' sam 2x\n\nVER2\nBudi se svi te zovu muzika\nSe cuje\nZaigrajmo skupa cijelo\nDrustvo tu je\n\nTata spava, svuda\nJe tama\nNiko nece znati da si bila\nS' nama\nCekacu te jos trenutak\nMala moja\n\nOnda odoh plesat' sam 2x\n\nJer to je mala moja\nRock and roll 5x\nMala to je rock\n\nVER2 solo\n\nJer to je mala....\n\nVER2\n\nSAM 2x	\N	\N	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
67	Nek ti bude kao meni	Nina Badrić	Hm	Srednja	Jazzy	Hrvatska	Žensko	Noć ostavljena tu\nsamo da mi lice sakrije\nja ponovo na dnu\nmolim za sve tvoje dodire\ni nemam snage\nni glasa pustiti\nod tuge koju sada osjećam\ni mada znam da me noćas ostavljaš\nja molit ću za svaki poljubac\n\nref: 2x\nNek ti bude kao meni\nda se duša poput stakla razlomi\ni nek ti bude kao meni\nvjeruj mi\nja neću žaliti\n\nPogled tvoj\nsve mi govori\ni svaka riječ bi bila previše\ni pusti me ,pusti da ne zaplačem\njer opet sve u meni umire\ni nemam snage\nni glasa pustiti\nod tuge koju sada osjećam\ni mada znam da me noćas ostavljaš\nja molit ću za svaki poljubac\n\nRef: 1x\n\nSolo\n\nRef: 2x	\N	\N	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
68	Nije htjela	Kemal Monteno & Oliver Dragojević	C	Srednja	Balada	Hrvatska	Žensko	NIJE HTJELA - C\nProsla je kroz moje pjesme strasno\ni u svakoj ostavila trag\nshvatio sam, al' je bilo kasno\nda joj nisam drag\n\nGodine su ostale za nama\ncvijetna polja, mladosti i sve\nostao sam sam, ostao sam sam\njer nikad vise vratiti se nece\nnikad vise\n\n\nRef. 2x\nNije htjela, nije htjela\nmoje pjesme, moju ljubav, moja djela\nnije htjela ruke moje\nsvoju ljubav, nije dala srce svoje\n\nNa na na na na na na na\nNa na na na na na na na\nNa na na na na na na na na na na na na na\n\nSvaka njena rijec jos uvijek boli\niako vec dugo nije tu\nsrce jos ne prestaje da voli\nda voli nju\n\nNije lako naci prave rijeci\nove noci kad se dijeli sve\nostao sam sam, ostao sam sam\njer nikad vise vratiti se nece\nnikad vise\n\nRef. 2x\n\nNije htjeelaa\n\nNa na na na na na na na\n\nNa na na na na na na na\n\nNa na na na na na na na na na na na na na (2x)\n\nNije htjela	\N	\N	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
69	Oči boje kestena	Ivana Brkić	Fm	Srednja	Trash	Hrvatska	Žensko	uvod    2x\n\nSjećaš li se još\nkako je kasnio brzi vlak\nk'o besana noć\npredugo trajao je taj sat\n\nNa peronu srce ostalo je\nkao rijeka bez vode, bez utjehe\ni zato ne pitaj za mene\n\nRef. 1x\nZaboravi, ne traži oči boje kestena\nzaboravi, kišni dan pokraj Dunava\nzaboravi, ne traži oči boje jeseni\ngodine nećeš vratiti\n\nuvod     2x\n\nPamtiš li još sad\nzelena svjetla kolodvora\ndva mokra goluba\nstakla od kiše zamagljena\n\nNa peronu srce ostalo je\nkao rijeka bez vode, bez utjehe\ni zato ne pitaj za mene\n\nRef. 1x\n\nuvod  1x \n\nZaboravi, ne traži oči boje kestena\nzaboravi, kišni dan pokraj Dunava	\N	\N	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
71	Oduzimaš mi dah	Colonia	Cism	Srednja	Jazzy	Hrvatska	Žensko	Koliko dugo već te poznajem\ncina se kao godinama\ni svaki put kada te dotaknem\nosjetim klecaj u koljenima\n\nDrhtaji moji sve ti govore\nko da je prvi put\nmilijun bubnjeva u srcu mom\nudara\n\nRef.\nOduzimaš mi dah, za tobom ludim\nvolim svaki tvoj\nosmijeh dok se budim\nvolim tvoje usne kad tiho krenu\npoljupcima u novi dan\n\nOduzimaš mi dah, ostajem bez rijeci\nu krilu tvom nema kraja sreći\nvolim tvoje usne kad tiho krenu\npoljupcima u novi dan\n\nuvod, Danijel solo\n\nKoliko dugo sam te čekala\nčini se kao stoljećima\nsamo je jedna ljubav zauvijek\ntraje do kraja vremena\n\ndrhaji …\n\nRef.\n\nBrake, uvod, Marko solo refren	\N	\N	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
73	Olivera	Đorđe Balašević	E	Brza	Zabavno	Hrvatska	Muško	Uvod klavijature 2 kruga\n\nNa pragu svojih dvadesetih\nbio sam laka roba,\nbile su moderne barabe onih dana.\n\nNe želim svega ni da se setim,\nhteo sam, eto, sve da probam,\nzvalo me zabranjeno voæe s raznih grana.\n\nRef.1x\n\nSad žalim, da,\nal' šta sam znao ja?\nTi si bila još devojèica.\nLeteo je kao leptir tvoj èuperak.\n\nDrugi bi sve\nimalo smisao,\ndrukèije bih život disao\nda sam znao da postojiš Olivera.\n\nKlavijature\n\nMožda sam a da nisam znao\npred isti izlog s tobom stao,\nmožda smo zajedno iz voza negde sišli?\n\nMožda si sasvim blizu bila,\nulicom mojom prolazila\ni možda smo se na trenutak mimoišli?\n\nSad žalim, da,\nal' šta sam znao ja?\nTi si bila još devojèica,\ndaleko od oga oka i mog pera.\n\nDrugi bi sve\nimalo smisao,\nne bih svakoj pesme pisao\nda sam znao da postojiš Olivera.\n\nSolo gitara\n\nDrugi bi sve\nimalo smisao,\nja bih iz te gužve zbrisao\ni nikom ne bi bilo jasno šta ja to smeram.\n\nZnao bih gde\nda sebi naðem mir,\nskrio se u tajni manastir\ni èekao da ti odrasteš Olivera 2x	\N	\N	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
74	Ostala si uvijek ista	Mišo Kovač	Dm	Srednja	Zabavno	Hrvatska	Žensko	uvod\nOdavno već nisam\nmislio o tebi\nmeđu nama dani\ni godine stoje\nnikada te vise\npronašao ne bi\nda se jučer nismo\nvidjeli nas dvoje\n\n\nStigao sam kasno\nstajao na cesti\ni slučajno tebe\nugledao tada\nni slutili nismo\nda ćemo se sresti\npod svijetlima ovog\nbezimenog grada\n\nRef.\nPričaš mi o svemu\nhodamo polako\nodavno se nismo\nisplakali tako\nostala si uvijek ista\ni ove suze na licu tvom\nostala si uvijek ista\njedina žena na putu mom\nostala si uvijek ista\nuvod\n\nStigao sam kasno ...\nref:\nuvod	\N	\N	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
75	Paloma Nera	Severina	D	Brza	Zabavno	Hrvatska	Žensko	Paloma blanca putuje\nna daleke obale\npaloma nera ostaje\nnema tebi do mene\npaloma nera\n\nDa je meni nebom letjeti, ulala, ulala, nebom letjeti\ni na tvoje rame sletjeti, ulala, ulala, rame sletjeti\n\nŠaptala bih nježne rijeci ljubavne\nnigdje nećeš naći bolju od mene\ni sve ptice kada jugu polete\ntvoja mala s tobom ostaje\n\nRef.\nPaloma blanca putuje\nna daleke obale\npaloma nera ostaje\nnema tebi do mene\n\nMa šta će meni blaga sva\nkada tebe imam ja\njer ti si moje najdraže\ni srcu mom najmilije\nja sam tvoja ljubav sva\ni sreća najveća\n\n\nsolo guitar\nDa je meni oči sklopiti, ulala, ulala, oči sklopiti\niznad mora tebe ljubiti, ulala, ulala, tebe ljubiti\n\nŠaptala bih nježne rijeci ljubavne ….\n\nref:	\N	\N	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
76	Pisma ljubavna	Prljavo Kazalište	H	Srednja	Pop / Rock	Hrvatska	Muško	Svi pacijenti k'o i doktori\nSvi vojnici, a i pukovnici\nSvi zandari, a i svi lopovi\nSvi su, duso, s tobom spavali\n\nCijele noci stojim\nIspod njenog prozora\nOna kaze: mali, mars\nSoba je zauzeta\n\nTi nisi bogat\nA nisi bas ni lijep\nMeni treba neka prava lova\nA ne jadan svijet\n\nRef.\nJedini bas ja\nNisam nikada\nJa sam pisao\nPisma ljubavna\n\nSolo, VER1 Ref	\N	\N	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
79	Prijateljice	Severina	G	Spora	Zabavno	Hrvatska	Žensko	Azurno nebo čekamo zoru\npet- šest mladih golubica\nnasmiješena su im lica\ni poslije mnogo godina\nu mome srcu draga sličica\n\nZajedno smo momke gledale\nzajedno po rivi šetale\npravile se da smo važne\nma da smo pametne i snažne\nsanjale smo zemlje daleke\n\nRef.\nHej ljepotice moje prijateljice\ngdje su naši snovi ostali\nhej sve smo mi kao ptice selice\nsvaka svome jugu odleti\n\nDjevojčice, žene postale\na neke su se već  i udale\nja još čekam azurne zore\nma ja još želim preplivati more\nja još sanjam zemlje daleke\n\n\n\nsolo violina\n\nRef.\nHej ljepotice  ..\n\nsvaka svome jugu odleti	\N	\N	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
80	Program tvog kompjutera	Denis & Denis	C	Brza	Pop / Rock	Ex-Yu	Duet	Program tvog kompjutera           \n\nuvod (na 4 svi zajedno)\n\nTi me slijediš, bježim i gubim dah\nneka jaka želja opija mi strah\nkoji korak još i kraj ulice\n\nSrce divlje lupa, želim te\nja ti brišem suze vodim te u stan\ndok polako pogled moj spušta se\n\nRef.\nSada pratim ritam tvoj\novu pjesmu novi broj\nako želiš bit ću ja\nprogram tvog kompjutera\n\nuvod\n\nMrak je, tražim svjetlo, ti spremaš ključ\nu prazninu tonem tvoj je dodir vruć\ndok mi diraš kosu ja gledam te\n\nRef. 1x\n\nsolo\n\nRef: 2x	\N	\N	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
81	Proud Mary	Tina Turner	D	Brza	Pop / Rock	\N	Žensko	Tina TurnerProud Mary\n\nLeft a good job in the city\nWorkin' for the man ev'ry night and day\nAnd I never lost one minute of sleepin'\nWorryin' 'bout the way things might have been\n\nBig wheel keep on turnin'\nProud Mary keep on burnin'\nRollin', rollin', rollin' on the river\n\nCleaned a lot of plates in Memphis\nPumped a lot of pane down in New Orleans\nBut I never saw the good side of the city\n'Til I hitched a ride on a river boat queen\n\nBig wheel keep on turnin' ….\nsolo gitara\n\ntu, tu,  i u podlozi idućem versu\n\nIf you come down to the river\nBet you gonna find some people who live\nYou don't have to worry 'cause you have no money\nPeople on the river are happy to give\n\nBig wheel keep on turnin'  ….	\N	\N	Strano	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
82	Put ka sreći	Goran Bare	G	Srednja	Zabavno	Hrvatska	Muško	Gdje je nestao covjek\ngdje se skrivao\niz vagona godina\nna tracnice ispao\n\nGleda gdje su znakovi\nkojim putem krenuti\nmoze li itko reci\ngdje je put ka sreci\n\n\nSamo zivi, samo budi\nsvi odgovori doci ce sami\nsamo stoj na svjetlu\ni doci ce kraj tami\n\nTEMA 1x\n\nKakva je to istina\nkad s druge strane je laz\nizvrnute vrijednosti\nstrah, samo strah\n\nNeostvareni snovi\nradis ono sto ne volis\nali mogu ti reci\ngdje je put ka sreci\n\nSamo zivi, samo budi\nsvi odgovori doci ce sami\nsamo stoj na svjetlu\ni doci ce kraj tami\n\nTEMA 2x\n\nKako dugo ce postojati\nkako dugo ce nestajati\nzelje, potrebe, osjecaji\nko ih koce i pokrecu\n\nTebe, mene, svo to vrijeme\nsrca tvrda k'o kamenje\nda mogu ti reci\npokazat' put ka sreci\n\nSamo zivi, samo budi\nsvi odgovori doci ce sami\nsamo stoj na svjetlu\ni doci ce kraj tami	\N	\N	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
83	Rijeka snova	Neno Belan	Fism	Srednja	Pop / Rock	Hrvatska	Muško	Svud, osjećam te oko sebe\ni stalno ćutim one riječi\nkoje su mi potrebne\n\nZnam, vezao sam se uz tebe\nal' pružila si mi slobodu\ndugo sam je tražio\n\n\nRijeka snova, vrelo nade\nvrtlog želja, život moj\nnašao sam sve na ovoj obali\n\nMoje oči sad trepere\npoput zvijezda sjaje se\nu daljinu gledam, ljubav ondje je\n\nRef.\nU-hu, tko si ti\nšto me ljubiš tako nježno\ndok na nebu sviće zora\n\nU-hu, tko si ti\nšto te slušam kako dišeš\nblizu uspavanog mora\n\nSOLO klavir+gitara\n\nSVE PONOVNO\n\nSOLO klavir+gitara\nRef.\nU-hu, tko si ti .....	\N	\N	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
84	Sanjao sam moju Ružicu	Leteći Odred	Fism	Brza	Pop / Rock	Hrvatska	Muško	Sanjao sam moju Ruzicu\npalila me je ko sibicu\nsanjao sam ruke njene\nda je sada pored mene\ngorio bi kao vatra olimpijska\n\nPisao sam mojoj Ruzici\na u pismu marke, dolari\ndao bi joj sve najbolje\nma samo nek je dobre volje\nne bi vise tuzan bio ja\nPjevali smo stare pjesme\nradili i sto se ne smije\nali nikad nismo varali\n\nVoljeli smo staro mjesto\nodlazili tamo cesto\ngdje smo prvi put se ljubili\n\nSanjao sam miris kestena\nna papiru tajna pisana\nsanjao sam miris zime\na na usni njeno ime\nnikad vise necu reci ja\n\nJer pisala je meni Ruzica\nmogu ja bez tvojih dolara\nma trebaju mi ruke radi\nda me griju kad zahladi\nudala se moja Ruzica\n\nRef., solo , Ref.2x , kraj	\N	\N	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
85	Shallow	Lady GaGa	Em	Spora	Balada	\N	Duet	Tell me something, girl\nAre you happy in this modern world?\nOr do you need more?\nIs there something else you're searchin' for?\nI'm falling\nIn all the good times,\nI find myself longin' for change\nAnd in the bad times,\nI fear myself\n\nTell me something, boy\nAren't you tired\ntrying to fill that void?\nOr do you need more?\nAin't it hard keeping it so hardcore?\nI'm falling\nIn all the good times,\nI find myself longing for change\nAnd in the bad times,\nI fear myself\n\nI'm off the deep end, watch as I dive in\nI'll never meet the ground\nCrash through the surface,\nwhere they can't hurt us\nWe're far from the shallow now\n\nIn the sha-ha, sha-ha-llow\nIn the sha-ha-sha-la-la-la-llow\nIn the sha-ha, sha-ha-llow\nWe're far from the shallow now\n\nOh, ha-ah-ah\nAh, ha-ah-ah, oh, ah\nHa-ah-ah-ah\n\nI'm off the deep end, watch as I dive in\nI'll never meet the ground\nCrash through the surface,\nwhere they can't hurt us\nWe're far from the shallow now\n\nIn the sha-ha, sha-ha-llow\nIn the sha-ha-sha-la-la-la-llow\nIn the sha-ha, sha-ha-llow\nWe're far from the shallow now	\N	\N	Strano	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
86	Should I stay should i go	The Clash	D	Srednja	Pop / Rock	\N	Žensko	[Intro]\nOh! Hola!\n\n[Verse 1]\nDarling, you got to let me know\nShould I stay, or should I go?\nIf you say that you are mine\nI'll be here till the end of time\nSo you got to let me know\nShould I stay, or should I go?\n\n[Verse 2]\nIt's always tease, tease, tease\nYou're happy when I'm on my knees\nOne day it's fine, and next it's black\nSo if you want me off your back\nWell, come on and let me know\nShould I stay, or should I go?\n\n[Chorus]\nShould I stay, or should I go now?\nShould I stay, or should I go now?\nIf I go, there will be trouble\nAnd if I stay, it will be double\nSo come on and let me know\n\n \n\n[Verse 3]\nThis indecision's bugging me (Esta indecisión me molesta)\nIf you don't want me, set me free (Si no me quieres, librarme)\nExactly whom I'm supposed to be (Dígame que tengo ser)\nDon't you know which clothes even fit me? (¿Sabes que ropa me queda?)\nCome on and let me know (Me tienes que decir)\nShould I cool it, or should I blow? (¿Me debo ir o quedarme?)\nSplit\n\nShould I stay, or should I go now? (Yo me enfrío o lo soplo)\nShould I stay, or should I go now? (Yo me enfrío o lo soplo)\nIf I go, there will be trouble (Si me voy va a haber peligro)\nAnd if I stay, it will be double (Si me quedo sera el doble)\nSo ya gotta let me know (Me tienes que decir)\nShould I cool it, or should I blow? (Tengo frío por los ojos)\nShould I stay, or should I go now? (Tengo frío por los ojos)\nIf I go, there will be trouble (Si me voy va haber peligro)\nAnd if I stay, it will be double (Si me quedo será el doble)\nSo ya gotta let me know (Me tienes que decir)\nShould I stay, or should I go?	\N	\N	Strano	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
87	Stojim na kantunu	Neno Belan	C	Srednja	Pop / Rock	Dalmacija	Muško	Stojin na kantunu, glava u balunu\nA, di si ti.\nStojin na kantunu, glava u balunu\nA, di si ti.\nMala, mala, mala\nLipa moja mala, yeah ...\n\nJa zbog tebe šizin, toliko te volin\nA, di si ti.\nJa zbog tebe šizin, toliko te volin\nA, di si ti.\nMala, mala, mala\nLipa moja mala, yeah ...\n\nKad me druga traži, ja san u garaži\nA, di si ti.\nKad me druga traži, ja san u garaži\nA, di si ti.\nMala, mala, mala\nLipa moja mala, yeah ...\n\nLipa moja mala, yeah...\n\nKraj	\N	\N	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
88	Šumica	Ivana Banfić	C	Brza	Trash	Hrvatska	Žensko	Šumica sva se trese\nljube se svi odreda\ntoplo je more plavo\nmjesec nas samo gleda\n\nNoćno kupanje\naj, aj, aj, aj.   (2x)\n\nRef. 2x\nNajljepše je\nu moru biti gol\nposlije je s tebe\nfino papat sol\n\nČeka nas crno vino\nlupit ce nas u glavu\nmasline i tvoje usne\nvidjet ćeš feštu pravu\n\nNoćno kupanje\naj, aj, aj, aj.   (2x)\n\nRef. 4x\n\nUmbaja\n\nmodulacija\n\nRef. 4x	\N	\N	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
89	Svatovska	Maja Šuput	A	Brza	Tambure	Hrvatska	Žensko	Gle vesele nam svatove\nsretan kog se u njih zove\nhajmo popiti sve sto imamo\nsami sjedit na to pravo nocas nemamo\n\nRef.\nVadi kume kes, kes\nnema nocas os, nes\nnema nocas ima, nema\nnikome se ne drijema\n\nVidi nasu lipu mladu\nma, nema je u selu, gradu\npogledajte nju, tu ljepoticu\ncini ti se k'o da gledas sliku svetacku\n\nRef.\n\nGle mladenca, blago meni\nodmah vidis 'ko se zeni\ndo jucer se jos za svakom okreco\nal' je danas drugi covjek jer se obeco\n\nRef.\n\nHajde, kume, 'drisi kesu\nma, kumovi su to sto jesu\nsto da sviramo tebi na uho\nal' svatovi nas ne mogu pratit na suho\n\nRef. 2x	\N	\N	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
90	Sweet Dreams	Eurythmics	Cm	Srednja	Pop / Rock	\N	Žensko	uvod\n\n Sweet dreams are made of this\nwho am i to disagree\ni travel the world and the seven seas\neverybody’s looking for something\n\n some of them want to use you\nsome of them want to get used by you\nsome of them want to abuse you\nsome of them want to be abused\n\n uuuu\n\n Sweet dreams….\n\n Uuuuu\n\n hold your head up\nmovin’on                        4x\nkeep your head up\nmovin’on\n\nsolo orgulje\n\n some of them….\n\n Uuuu\n\n Sweet dreams …..    4x\nSweet Dreams are made of this	\N	\N	Strano	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
91	Takvi kao ti	Nina Badrić	Cism	Srednja	Pop / Rock	Hrvatska	Žensko	uvod\n\nJa poznam takve kao ti\nšarmere, neodoljive\nma takvi sebe vole najviše\nUvijek uglađen i fin\nma stvarno pravi mamin sin\njer mama ipak zna najbolje\n\nBaš takvog sam ja čekala\nda zavrtim mu tlo pod nogama\ni nimalo neću žaliti\nako ćeš zbog mene plakati\n\nRef. 2x\nProkleto je, sve što je od tebe\nimaš riječi najslađe\nal' fali ti još tisuću jedna bolja za mene\njer takve kao ti, ja provalim za tren\nda se ne okrenem\n\n     dam dirli dam\nI meni je majka pričala\nčuvaj se Nina mangupa\njer takvi znaju lagat' najbolje\nTaj nema srce čovjeka\nkoji te voli do vijeka\ntebe voli, a za drugom umire\n\nBaš takvog sam ja čekala …\n\nRef.2x\n\nuvod\n\nref: 2x	\N	\N	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
92	Tek je 12 sati	E.T.	Dm	Brza	Trash	Hrvatska	Žensko	⇥Tek je 12 sati⇥\n\nuvod klavir + vocal         repanje smo izbacili\n\nRef.\nTek je 12 sati\nzavedi me da ne bude dosadno\nona neće znati\nda smo bili zajedno\n\nTek je 12 sati\nosvoji me da bude nam opasno\nvoljela bih znati\nmisliš li na mene kad si s njom\nTek je 12 sati\n\nSada znam da nema razloga\npredugo bježim od tvog pogleda\ni sanjam da smo sami\ni mrak oko nas\nsačuvaj ljubav za nju\nu meni nađi spas\n\nDovoljan je jedan znak\ni učinit ću sve\nne trebam ja s tobom brak\nbas me briga što si njen\n\nsve ponovno	\N	\N	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
93	Teške boje	Goran Bare	Gism	Srednja	Pop / Rock	Hrvatska	Muško	Moje srce teško suzu pušta\ni pumpa sa smiješkom\njer ja ću pjevati i evo pjevam\nja ne svijetlim, ja sijevam\n\nUuuu teške boje\nnjima ja sam obojen\n\nPokreni me, sa mnom pleši\ntuge, tuge me riješi\ndaj da budem onaj, koji tješi\nsvakom onom, koji zna da griješi\n\nUuuu teške boje\nnjima ja sam obojen\n\nUvod+ gitara++bubanj\n\nReci mi, Bože, koje si boje kože\nBože, daj kaži, to o tebi da l' su laži\nti znaš sve, tako bar govore\nmora da je super gore\nkad se prozori raja otvore\n\nUuuu teške boje\nnjima ja sam obojen\n\nNjima ja sam obojen 2x	\N	\N	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
94	This Love	Maroon 5	Cm	Srednja	Pop / Rock	\N	Muško	I was so high I did not recognize\nThe fire burning in her eyes\nThe chaos that controlled my mind\n\nWhispered goodbye as she got on a plane\nNever to return again\nBut always in my heart, oh\n\nThis love has taken its toll on me\nShe said goodbye too many times before\nAnd her heart is breaking in front of me\nAnd I have no choice, 'cause I won't say goodbye anymore\n\nWhoa\nWhoa\nWhoa\n\nI tried my best to feed her appetite\nKeep her coming every night\nSo hard to keep her satisfied, oh\nKept playing love like it was just a game\nPretending to feel the same\nThen turn around and leave again, but uh-oh\n\nThis love has taken its toll on me\nShe said goodbye too many times before\nAnd her heart is breaking in front of me\nAnd I have no choice, 'cause I won't say goodbye anymore\n\nWhoa\nWhoa\nWhoa\n\nI'll fix these broken things, repair your broken wings\nAnd make sure everything's alright (it's alright, it's alright), oh, oh\nMy pressure on your hips, sinking my fingertips\nInto every inch of you because I know that's what you want me to do\n\nThis love has taken its toll on me\nShe said goodbye too many times before\nHer heart is breaking in front of me\nAnd I have no choice 'cause I won't say goodbye anymore\n\nThis love has taken its toll on me\nShe said goodbye too many times before\nAnd my heart is breaking in front of me\nShe said goodbye too many times before\n\nWoah\nWoah\nWoah\n\nKraj	\N	\N	Strano	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
95	Ti si mi u mislima	Dino Dvornik	Am	Brza	Funky	Hrvatska	Muško	Uvod.\n\nTi, ti si mi u mislima\nTi, ti si mi u grudima\nJos plovis mi u zilama 2x\n\nJos lutas mi po mislima\nCak i sada kada nisam tvoj\nJos drzis me u zubima\nBez tebe nisam vise svoj\nI kako sada da se oprostim od tebe\nI kako sada da zaboravim na sve\n\nTi dizes me do oblaka\nTi spustas me u grob\nTi grad si moga sumraka\nA ja sam uvijek tvoj sam rob\nI kako sada da se otkacim od tebe\nI kako sada da zaboravim na sve\n\nTi, ti si mi u mislima\nTi, ti si mi u grudima\nJos plovis mi u zilama\nJa sam covjek tvoj,2x solo git. solo kljave\n\nTi, ti si mi u mislima\nTi, ti si mi u grudima\nJos plovis mi u zilama\nJa sam covjek tvoj,2x solo k.\nTi ti si mi	\N	\N	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
96	To mi radi	Crvena Jabuka	E	Srednja	Pop / Rock	Ex-Yu	Muško	Volim te, djevojcice\ndok se nebo zatvara\nneka vriste nase ulice\nneka krene zabava\n\nBolja buducnost nije htjela\nnas da saceka\npridji blize da vidim tajnu\nkoju cuvas u ocima\n\n\nRef.\nTo mi radi, to mi radi\njer ti mozes\nda mi radis sve\nto mi radi, to mi radi\njer ja zaljubio sam se\n\nIza ugla cujem muziku\ngeneracija je cugala\na ja sam nocas slican urliku\nmoje je ime teska panika\n\nKad me palis, onda idi\nlomi do kraja\npridji blize da vidim tajnu\nkoju cuvas u ocima\n\nRef. 2x\n\nIza ugla...\n\nRef. 2x	\N	\N	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
97	Tvoja prva djevojka	Severina	Cm	Brza	Pop / Rock	Hrvatska	Žensko	uvod\n\nDošao si tiho na prstima\nrekao da sam tvoja jedina\npričali smo i svjetlo ugasili\nmalo se ljubili\nNoć je bila duga, sva od zvjezdica\nna putu do Mjeseca\ndanas si daleko dvjesto godina\nali si na usnama\n\nRef\n\nBila sam tvoja prva djevojka\nsva tvoja ljubav tu je ostala\ni svaku noć sanjaš me\nu svakoj drugoj tražiš me\ntvoja prva djevojka\n\nuvod\n\nsve ponovno\n\nref: 1x\n\ni svaku  noć ... \n\nuvod  1x  i  solo 4x\n\nref: 1x\n\ni svaku  noć ...	\N	\N	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
99	U ljubav vjere nemam	Oliver Dragojević & Gibonni	B	Srednja	Pop / Rock	Dalmacija	Muško	Dušu sam potrošio, zbog toga ne žalim, yeah\nSve sam svoje prošao\nBezbroj prečica do sna, bezbroj slijepih ulica\n\nSrce se umorilo i ne znam šta ću s njim, oh ne\nU šta sam se pretvorio?\nSretan ili nesretan, ja samo jedno znam\n\nNju da sam ženio, ne bih tako uvenuo\nStarim ja a u ljubav vjere nemam\nSvoju djecu sam sanjao\nNjenim ih imenom nazvao\nStarim ja a u ljubav vjere nemam\nStarim ja, a u ljubav vjere nemam\n\nU ljubav vjere nemam\nA u ljubav vjere nemam\nU ljubav vjere nemam\n\nDušu sam potrošio, zbog toga ne žalim\nSve sam svoje prošao\nSretan ili nesretan, ja samo jedno znam\n\nNju da sam ženio, ne bi tako uvenuo\nStarim ja a u ljubav vjere nemam\nSvoju djecu sam sanjao\nNjenim ih imenom nazvao\nStarim ja a u ljubav vjere nemam\nStarim ja a u ljubav vjere nemam\n\nU ljubav vjere nemam\nA u ljubav\nU ljubav vjere nemam\nAjmo, ruke gore\n\niz svega grla\nSvoju (djecu sam sanjao)\n(Njenim ih imenom nazvao)\nStarim ja a u ljubav vjere nemam\nStarim ja a u ljubav vjere nemam\n\nA u ljubav vjere nemam\nA u ljubav, u ljubav vjere nemam ja\nA u ljubav vjere nemam ja\nU ljubav vjere nemam\nStarim ja a u ljubav vjere nemam\n\nA u ljubav vjere nemam ja\nU ljubav vjere nemam, nemam, nemam, ne	\N	\N	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
100	U meni jesen je	Teška Industrija	Cm	Srednja	Pop / Rock	Hrvatska	Žensko	uvod gitara+ sint\n\nStiglo je proljeće\na mene isti stari nemir pokreće\nda se šuljam noću kradom\ntvojom ulicom\n\nI da tu čekam ja\npod tvojim prozorom u sjeni bagrema\nda te gledam kako žuriš\nkad mi dolaziš\n\n\n⇥Sve isto je k'o nekada\n⇥sve isto je, ali ništa isto nije\n\nRef. 2x\nU meni jesen je\nmada kažu svi da sad je proljeće\nu meni tuga je\njer si ti ko zna gdje\n\nStiglo je (Miriše) proljeće \n\ni ptice s' juga već nam nazad dolaze\nsamo ti, samo ti, ti ne dolaziš\n\ntko li se iskrada \n\niz tvoje postelje kad slavuj zapjeva\nda l' se tad sjetiš nas\nbarem i za čas\n\n⇥Ovdje (Sve isto) je k'o nekada\n⇥sve isto je, ali ništa isto nije\n\nRef. 2x\n\n          brake    \n\nRef 1x	\N	\N	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
101	Ugasi me	Parni Valjak	E	Srednja	Pop / Rock	Ex-Yu	Žensko	Ugasi me , zar ne vidiš da gorim \nsmiri me , zar ne znaš da se bojim\nPovedi me , sa tobom ću do kraja\npovedi me , za tobom ću do kraja\n\nKako je dobro da te imam \nkako je dobro da te imam\nsmiri me, onako kako znaš\n\nImaš ruke, koje govore \nruke koje vide sve\ntvojim očima ja vjerujem \npovedi me, povedi me\n\nuvod\nUgasi me, zar ne vidiš da gorim \nsmiri me, zar ne znaš da se bojim\nPovedi me, sa tobom ću do kraja \npovedi me, za tobom ću do kraja\n\nKako je dobro da te imam \nkako je dobro da te imam\nsmiri me, onako kako znaš\nsmiri me, samo ti to znas\n\nSmiri me ...	\N	\N	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
102	Valerie	Amy Winehouse	Dis	Brza	Pop / Rock	\N	Žensko	Well, sometimes I go out by myself\nAnd I look across the water\nAnd I think of all the things, what you're doin'\nAnd in my head, I paint a picture\n\n[Chorus]\nSince I've come on home\nWell, my body's been a mess\nAnd I've missed your ginger hair\nAnd the way you like to dress\nWon't you come on over?\nStop makin' a fool out of me\nWhy don't you come on over, Valerie?\nValerie, yeah\nValerie\nValerie\n\n[Verse 1]\nDid you have to go to jail?\nPut your house on   up for sale?\nDid you get a good lawyer?\nhope you didn't catch a tan\nhope you'll find the right man\nWho'll fix it for ya\n\n\n\n[Verse 2]\nAnd are you shoppin' anywhere?\nChanged the colour of your hair?\nare you busy?\nAnd did you have to pay that fine\nThat you were dodgin' all the time?\nAre you still dizzy?\n\n[Chorus]\nSince I've come on home  …\n\n\n\n[Refrain]\nWell, sometimes I go out by myself\nAnd I look across the water\nAnd I think of all the things, what you're doin'\nAnd in my head, I paint a picture\n\n[Chorus]\nSince I've come on home …..\n\nValerie (7)\n\nWhy don't you come on over, Valerie	\N	\N	Strano	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
103	Vilo moja	Vinko Coce	Gm	Spora	Balada	Dalmacija	Žensko	VER1\nSkoro saki put\nkad se mi pogjedamo\nti i ne odzdravis\nk'o da se ne poznamo\n\nCHORUS\nA da mi te sebi zvat\nkad ces zaspat\nprvo sna da ti recen\nda volin te jos\n\nVolin te jos (bekovi)\n\n\nRef.\nVilo moja\nti si moj san, ti si moj san\n\na lagje bilo bi da si tuja mi\nda te ne poznan, da te ne znan x2\n\nVER1\n\nCHORUS\n\nRef.\nVilo moja\nti si moj san, ti si moj san\n\na lagje bilo bi da si tuja mi\nda te ne poznan, da te ne znan x2\n\n\nVilo moja, vilo moja	\N	\N	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
104	Volim osmijeh tvoj	Toše Proeski & Antonija Šola	Em	Srednja	Pop / Rock	Hrvatska	Duet	Volim osmijeh tvoj            \n\nuvod gitara\n\nKrade mi te cesta, kradu mi te ljudi\nsvako pomalo od osmijeha tvog posudi\n\nIza svakog ugla stalno netko vreba\nda mi te ukrade kada malo sreće treba\n\nNitko nije kriv za to\nšto te volim toliko\nal' osmijeh tvoj je kriv da znaš\nšto me osvajaš\n\nRef.\nVolim osmijeh tvoj baš dobro ti stoji\njoš ti bolje stoje poljupci moji\nma kriv je meni svako\nkom' smiješ se ti, moja ljubavi\n\nVolim osmijeh tvoj i nosi ga uvijek\nsmij' se samo, dušu mi grij' zauvijek\ni krivi su mi svi i krivo mi je sve\nkad sam bez tebe\n\nAl' nije krivo more, niti sol u kosi\nniti nebo koje boju oka tvoga nosi\n\n⇥Nitko nije ..\n\nRef.\nsolo gitara\nRef.\n\nI krivi su mi svi, i krivo mi je sve\nkad sam bez tebe	\N	\N	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
105	Walking on sunshine	Katrina & The Waves	A	Brza	Pop / Rock	\N	Žensko	Walking On Sunshine - Katrina & the waves\n\nuvid \nOh! Ohhhh yeeeh \n\nI used to think maybe you loved me\nnow baby I'm sure\nAnd I just cant wait till the day\nwhen you knock on my door\nNow everytime I go for the mailbox\ngotta hold myself down\nCos I just wait till you write me\nyour coming around \n\nref:\nI'm walking on sunshine , wooah\nI'm walking on sunshine, woooah\nI'm walking on sunshine, woooah\nand don't it feel good!! \nHey , alright now\nand dont it feel good!!\nhey yeh \n\nI used to think maybe you loved me,\nnow I know that it's true\nand I don't want to spend my life,\njust in waiting for you\nnot I don't want you back for the weekend\nnot back for a day , no no no\nI said baby I just want you back\nand I want you to stay \n\nwoah yeh!\nref: 1x\n\nsolo guitar\nwalking on sunshine,  walking on sunshine \nI feel the love,I feel the love, I feel the love that's really real 2x\nI'm on sunshine baby oh⇥2x\n\nref: 1x          (sa produženim krajem)	\N	\N	Strano	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
148	Zorica	Mejaši	Fism	Brza	Tambure	Hrvatska	Muško	Najbolja mi je do sad\r\nona bolja je od drugih svih\r\nsvi da kazu nije za mene\r\nopet nju odabrao bi\r\n\r\nMjesec luduje pa malo zazmiri\r\nkad joj dodjem da niko ne vidi\r\n\r\n\r\nRef. 2x\r\nA u zoru Zorica me budi\r\nhopa cupa cijelu noc je bilo\r\nslatko li je kad se tajno ljubi\r\na ne bi slatko, ne bi bilo da se nije krilo\r\n\r\nAfrika, paprika\r\nZorica\r\n\r\nJa bi s tobom uvijek sve\r\nsve bi bilo kad bilo je\r\nda me zelja nikad nemine\r\nmeni s tobom uvijek dobro je\r\n\r\nRef. 2x\r\n\r\nZorica\r\n\r\nRef. 2x	\N	\N	Domaće		0	\N	repertoar	\N	2026-03-28 09:48:56.694384	\N
106	White Christmas	Manifesto	Amai7	Spora	Jazzy	\N	Žensko	Verse 1:\nI'm dreaming of a white Christmas\nJust like the ones I used to know\nWhere the treetops glisten and children listen\nTo hear       sleigh bells in the snow\n\n Verse 2:\nI'm dreaming of a white Christmas\nWith every Christmas card I write\n"May your days be merry and bright\nAnd may all your Christmases be white"\n\nsolo \n\nVerse 3:\nI'm dreaming of a white Christmas\nJust like the ones I used to know\nWhere the treetops glisten and children listen\nTo hear the sleigh bеlls in the snow\n\n Verse 4:\nI'm dreaming of a white Christmas\nWith еvery Christmas card I write\n"May your days be merry and bright\nAnd may all your Christmases be white\n\n\n\nJa sanjam jedan bijel Božić\nDa opet dođe u moj grad\nDa su zvijezde gore\nI tiho da se stvore\nSvi ljudi koje volim ja\n\nJa sanjam kako snijeg pada\nI odmah tužan postanem\nJer kraj stare škole\nGdje se mladi vole\nNisam tebe pronašao ja\n\nJa sanjam ljeto u zraku\nDa opet dođe u moj grad\nDa su zvijezde gore\nI blizu da je more\nTek tada bit' ću sretan ja\n\nDa su zvijezde gore\nI blizu da je more\nTek tada bit' ću sretan ja, sretan ja	\N	\N	Strano	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
107	Childs Anthem	Toto	Cism	Brza	Pop / Rock	\N	\N	\N	\N	\N	Strano	\N	1	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
108	Cantaloupe Island	Herbie Hancock	Fm7	Srednja	Jazzy	\N	\N	\N	\N	\N	Strano	\N	1	static/scores/cantaloupe_island.pdf	repertoar	\N	2026-03-11 12:43:09.130888	\N
109	Opet je jubin cilin tilom	Ivica Sikirić Ićo	G	Srednja	Balada	Dalmacija	Muško	verse\nAko i postoji misto di jubavi\nNevira stane na put\nUčinit′ću sve što triba da zatvorin\nVrata što dovode tu\nI nije lako ni kada me pogledaš\nK'o da se prosula sol\nAko nešto krivo radin mi reci\nNemoj ništa kriti\nKad znaš da uvik san tvoj\n\nI, evo me sad\nOpet je jubin cilin tilon\nDok gledan je tu\nKako se spušta, sva u bilon\nPa, bi ′tija da san\n'ladna voda koja njeno lice umije\nI moran joj reć' da volin je\n\nAko i postoji misto di jubavi\nNevira stane na put\nUčinit′ću sve što triba da zatvorin\nVrata što dovode tu\nI nije lako ni kada me pogledaš\nK′o da se prosula sol\nAko nešto krivo radin mi reci\nNemoj ništa kriti\nKad znaš da uvik san tvoj\n\nI, evo me sad\nOpet je jubin cilin tilon\nDok gledan je tu\nKako se spušta, sva u bilon\nPa, bi 'tija da san\n′ladna voda koja njeno lice umije\nI moran joj reć' da volin je\n\n(O-o-o-o-o, o-o-o-o-o)\n(O-o-o-o-o-o-o)\n\nI, evo me sad\nOpet je jubin cilin tilon\nDok gledan je tu\nKako se spušta, sva u bilon\nPa, bi ′tija da san\n'ladna voda koja njeno lice umije\nI moran joj reć′ da volin je (da volin je)\nI, evo me sad\n(Opet je jubin cilin tilon)\n(Dok gledan je tu)\n(Kako se spušta, sva u bilon)\nPa, bi 'tija da san\n'ladna voda koja njeno lice umije\nI moran joj reć′ da volin je\noutro\nMoran joj reć′ da volin je	\N	\N	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
122	Za dobra stara vremena	Novi Fosili	A	Srednja	Zabavno	Hrvatska	Muško	Bilo je osam, na trgu cvijeća\r\nJa sam te čekao na kraju priče\r\nTada si rekla: Mi nećemo više\r\nOdmahnut rukom, ma što me se tiće\r\n\r\nAl' ne bi' ni Bogu priznao tada\r\nSve je moje u vodu palo\r\nSad mirno kažem, lagati neću\r\nOnoga dana i vrijeme je stalo\r\n\r\nKako je dobro vidjeti te opet\r\nStaviti ruke na tvoja ramena\r\nKao nekad poljubi me nježno\r\nZa ona dobra, dobra, dobra stara vremena\r\n\r\nStvarno sam htio, vidjeti te opet\r\nSa istim smijehom, na usnama tvojim\r\nPričaj o kiši, o bilo ćemu\r\nNe pričaj o sebi, još toga se bojim\r\n\r\nNeka sam proklet ako i danas\r\nPostoji način, da objasnim sebe\r\nNe želim nikog, i sve mi se čini\r\nDa čitav sam život volio tebe\r\n\r\nKako je dobro vidjeti te opet\r\nStaviti ruke na tvoja ramena\r\nKao nekad poljubi me njezno\r\nZa ona dobra, dobra, dobra stara vremena\r\n\r\nMa, baš je dobro vidjeti te opet\r\nStaviti ruke na tvoja ramena\r\nKao nekad poljubi me nježno\r\nZa ona dobra, dobra, dobra stara vremena	10	5	Domaće		0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
125	Bolje živim nego ministar	Mladen Grdović	F	Brza	Fešta	Dalmacija	Muško	Leti vrime, idu dani\nSve je isto ka i lani\nŽena kući, a ja vani\nPenzija mi u kavani\nBez brige mi idu dani\nŽena kući, a ja vani\nPenzija mi u kavani\nBez brige mi idu dani\n\nŽivim, živim, a ničega nemam\nPijem, pušim, loše mi se sprema\nNi me briga, nek′ sam zdrav\nNeću biti bogat star\nBolje živim nego ministar\nNi me briga, nek' sam zdrav\nIako sam podstanar\nBolje živim nego ministar\nHej\n\nU tri sata ja se budim\nOd pijanstva glava ludi\nŽivot teče ka i rijeka\nA za mene nema lijeka\nBećar sam od pamtivijeka\nŽivot teče ka i rijeka\nA za mene nema lijeka\nBećar sam od pamtivijeka\n\nŽivim, živim, a ničega nemam\nPijem, pušim, loše mi se sprema\nNi me briga, nek′ sam zdrav\nNeću biti bogat star\nBolje živim nego ministar\nNi me briga, nek' sam zdrav\nIako sam podstanar\nBolje živim nego ministar\nHej\n\nOd života ništa nemam\nVanzemaljac nešto sprema\nCile mille non piu mille\nGodine su proletile\nŽene su me ostarile\nCile mille non piu mille\nGodine su proletile\nŽene su me ostarile\n\nŽivim, živim, a ničega nemam\nPijem, pušim, loše mi se sprema\nNi me briga, nek' sam zdrav\nNeću biti bogat star\nBolje živim nego ministar\nNi me briga, nek′ sam zdrav\nIako sam podstanar\nBolje živim nego ministar\n\nBilje živim, bolje živim\nBolje živim nego ministar\nHej	\N	2	Domaće	nan	0	nan	repertoar	\N	2026-03-11 12:43:09.130888	\N
126	Kad si rekla da me voliš	Dino Merlin	Gism	Brza	Zabavno	BIH	Muško	ti nikad nisi ni u sali\no ljubavi sa mnom probala\nuvijek si neke odlikase kraj sebe\nk'o cuke vodala\n\nal' ko sem Boga zna\nkada gvozdje postaje grozdje\nal' ko sem Boga zna\nodakle to i kako dodje\n\nkad si rekla da me volis\n\nti nikad nisi ni u sali\no ljubavi sa mnom probala\nuvijek si neke odlikase kraj sebe\nk'o cuke vodala\n\nal' ko sem Boga zna\nda l' si budna il' spavas\nimas li pojma gdje sam sad\nda l' ti ista znaci ako cujes\nda dolazim u onaj grad\n\nkad si rekla da me volis\nprvi put kad si rekla to\nda ti tijelo gori\nkao sto nikad nije gorilo\nkad si rekla da me volis\nprvi put kad si rekla to\nkad si rekla da me volis\n\nal' ko sem Boga zna\nkada gvozdje postaje grozdje\nal' ko sem Boga zna\nodakle to i kako dodje\n\nal' moja dusa zna\nda l' si budna il' spavas\nimas li pojma gdje sam sad\nda l' ti ista znaci ako cujes\nda dolazim u onaj grad\n\nkad si rekla da me volis\nprvi put kad si rekla to\nda ti tijelo gori\nkao sto nikad nije gorilo\nkad si rekla da me volis\nprvi put kad si rekla to\nkad si rekla da me volis\n\npogledaj me sad\nskoro da sam sijedi starac\nto je opsjena\njos sam onaj isti\nsto bi dao sve\nna cemu mi zavide\nsamo za taj tren\nda to moje oci vide\n\nda l' si budna il' spavas\nimas li pojma gdje sam sad\nda l' ti ista znaci ako cujes\nda dolazim u zabranjeni grad\n\nda ti kazem da te volim\nzadnji put da izgovorim to\nda mi tijelo gori\nkao sto nikad nije gorilo\nkad si rekla da me volis\nprvi put kad si rekla to\nkad si rekla da me volis	\N	3	Domaće	nan	0	nan	repertoar	\N	2026-03-11 12:43:09.130888	\N
6	14 Palmi	Daleka Obala	A	Brza	Vlakić	Hrvatska	Muško	VER:\nCetrnaest palmi na otoku srece\nZalo po kojem se valja val\nI moja draga obasuta cvijecem\nLezi kraj mene, sretan sam ja\n\nREF:\nCetrnaest palmi se nadvilo nad nama\nSa zala sumi zapjenjeni val\nA moja draga obasuta cvijecem\nStrasno me ljubi, sretan sam ja\n\nSOLO GIT\nVER2:\nCetrnaest palmi sad vise ne rastu\nZalom se vise ne valja val\nA moja draga obasuta cvijecem\nNije kraj mene, tuzan sam ja\n\nREF:\nAl' nema veze sto palme ne rastu\nI sto se vise ne valja val\nI nema veze sto nema moje drage\nSa drugom sutra sretan bit cu ja\n\nSOLO 2\nREF:\nI nema veze sto palme ne rastu\nI sto se vise ne valja val\nI nema veze sto nema moje drage\nSa drugom sutra sretan bit cu ja [3x]	3	1	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
72	Oh! Suzanna	Country	C	Srednja	Vlakić	Hrvatska	Žensko	I come from Alabama with my banjo on my knee,\nI'm going to Louisiana, my true love for to see.\nIt rained all night the day I left, the weather it was dry\nThe sun so hot I froze to death, Susanna, don't you cry.\n\nChorus\n\nOh! Susanna, Oh don't you cry for me,\nFor I come from Alabama with my banjo on my knee.\n\nI had a dream the other night, when everything was still;\nI thought I saw Susanna dear, a coming down the hill.\nA buckwheat cake was in her mouth, a tear was in her eye,\nSays I, I'm coming from the south, Susanna, don't you cry.\n\nI soon will be in New Orleans, and then I'll look around,\nAnd when I find Susanna, I'll fall upon the ground.\nBut if I do not find her, then I will surely die,\nAnd when I'm dead and buried, Oh, Susanna, don't you cry.	3	3	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
70	Od mora do mora	Daleka Obala	C	Brza	Vlakić	Dalmacija	Muško	Ja nikad nisam znao\nKoliko sam ti dao\nA koliko sam primio\n\nRef.\n\nOd mora do mora\nKraj brodskog motora\nNa tebe sam mislio\n\nI nisam znao\nDa tebe volim ja\nDok me nije samoca ranila\n\nOd mora do mora\nKraj brodskog motora\nNa tebe sam mislio ja\n\nTi nikad nisi znala\nKoliko si mi dala\nA koliko si primila\n\nOd sobe do dvora\nOd dvora do mora\nNa mene si mislila\n\nAl' nisam znao da\nTebe volim ja\n\nDok me nije samoca ranila\n\nOd mora do mora\nKraj brodskog motora\nNa tebe sam mislio ja\n\nJa nikad nisam znao\nJe l' Fuji il' Mindanao\nJe l' Java il' Borneo\n\nRef.\n\nOd mora do mora\nKraj brodskog motora\nNa tebe sam mislio ja\n\nNa tebe sam mislio ja	3	2	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
128	Kad budemo ja i ti 63	Novi Fosili	H	Brza	Zabavno	Hrvatska	Žensko	Ako ti dozvolim\nda me sad poljubis\nnesto mi obecaj\nda me ne izgubis\n\nAko budem bolesna i vruca 39\nhoces li mi donjeti topli caj u krevet\nhoces li me cuvati i biti pored mene\na ne negdje ljubiti\nneke druge zene,priznaj mi\n\nHoces li me maziti\nhoces li me paziti\nhoces li me voljeti\nkad budemo ja i ti 63\n\nHoces li se sjetiti uvijek kupit cvijeca\nbez obzira na to\nkoliko torta ima svijeca\nako jednom budem ja debela i stara\nhoces li me zvati\nti sreco moja mala, priznaj mi	\N	2	Domaće	nan	0	nan	repertoar	\N	2026-03-11 12:43:09.130888	Ako ti dozvolim\r\nda me sad poljubis\r\nnesto mi obecaj\r\nda me ne izgubis\r\n\r\nAko budem bolesna i vruca 39\r\nhoces li mi donjeti topli caj u krevet\r\nhoces li me cuvati i biti pored mene\r\na ne negdje ljubiti\r\nneke druge zene,priznaj mi\r\n\r\nHoces li me maziti\r\nhoces li me paziti\r\nhoces li me voljeti\r\nkad budemo ja i ti 63\r\n\r\nHoces li se sjetiti uvijek kupit cvijeca\r\nbez obzira na to\r\nkoliko torta ima svijeca\r\nako jednom budem ja debela i stara\r\nhoces li me zvati\r\nti sreco moja mala, priznaj mi
133	Refužo	Dalmatino	A	Srednja	Zabavno	Dalmacija	Muško	[Strofa 1]\nBlago mome oku šta te gleda\nTi mi stižeš k'o najljepša vijest\nŠta nebesa nisu kocka leda\nZa naš stol ćeš skupa sa mnom sjest\nBlagoslivljan korak di si prošla\nSvaku stopu, treptaj oka tvog\nFala nebu šta si meni došla\nA priko praga te prinija sam Bog\n\n[Refren]\nMoje sunce, moja bila ružo\nOni šta se vole znaju to\nSamo jubav izuva postole\nI ka' rukon skida svaku bol\nMoje sunce, moja bila ružo\nOni šta se vole znaju to\nDa se jubav ne daje refužo\nI na fete ne stavlja na stol\n\n[Strofa 2]\nI kad sunce potone u more\nJa mu ne dan da dotakne dno\nJer bi more, podivljalo i bisno\nSrcu mome bilo pretisno\nYou might also like\nBozic Bijeli\nDalmatino\nBad Bunny - DtMF (English Translation)\nGenius English Translations\nRisk It All\nBruno Mars\n[Refren]\nMoje sunce, moja bila ružo\nOni šta sе vole znaju to\nSamo jubav izuva postole\nI ka' rukon skida svaku bol\nMoje suncе, moja bila ružo\nOni šta se vole znaju to\nSamo jubav izuva postole\nI ka rukon skida svaku bol\n\n[Refren]\nMoje sunce, moja bila ružo\nOni šta se vole znaju to\nSamo jubav izuva postole\nI ka' rukon skida svaku bol\n(Moje sunce)\nMoja bila ružo\nOni šta se vole znaju to\nDa se jubav ne daje refužo\nI na fete ne stavlja na stol\n\n[Završetak]\nDa se jubav ne daje refužo\nI na fete ne stavlja na stol	\N	10	Domaće	nan	0	nan	repertoar	\N	2026-03-11 12:43:09.130888	\N
127	Zove zove Jole Jole	Jole	Fism	Brza	Zabavno	Hrvatska	Muško	Zadnji mjesec mi je ote\nIzbrisala me je portret\nPoslijednju je crtu povukla\n\nAli nisam slab ni proklet\nŽivot meni hoda opet\nBoje se u lice vratila\n\nSreća ima lice žene\nSada samo ona mene\n\nZove, zove, zove ona mene\nZove, zove, zove, Jole, Jole\nNeka neka mene ona mene\nZove oko moje gotovo je\n\nMa da stižu tridesete\nJa sam sretan kao dijete\nIma želju da me poljubi\n\nNekad pravo mi i budi\nSvakakvih nas ima ljudi\nNek ' se sada ona potrudi\n\nSreća ima lice žene\nSada samo ona mene	\N	4	Domaće	nan	0	nan	repertoar	\N	2026-03-11 12:43:09.130888	\N
129	Kokolo	Magazin	G	Brza	Zabavno	Hrvatska	Žensko	Kokolo, Kokolo, Kokolo\nKokolo moj\nKokolo, Kokolo, Kokolo\nKad si bio moj\n\nMožda te se nebi više nikad sjetila\nDa baš ovih dana kuću nisam redila\nI u mnoštvu starih odbaćenih stvari\nNašla jedan predmet prahnjav ali dragi\n\nSpomenar je zbio naše tajne male\nU njemu su mnoge slatke riječi stale\nAli od svih onih pisanih imena\nSamo tvoje znam\n\nKokolo, Kokolo, Kokolo\nKokolo moj (ispod tog stojio potpis moj)\nKokolo, Kokolo, Kokolo\nKad si bio moj (onih dana kad je bio tvoj)\nKokolo, Kokolo, Kokolo\nKokolo moj (ispod tog stojio potpis moj)\nKokolo, Kokolo, Kokolo\nKad si bio moj\n\nVoljeli smo duge šetnje sasvim sami\nBrzo su nam tada prolazili dani\nSjećanje na tebe i sad mi se javi\nToga ljeta ti si bio onaj pravi\n\nOd tebe sam tada nadimak ja dobila\nK'o u nekoj priči ludo te zavoljela\nAli to su bili naši zadnji dani\nProšlost sad smo mi\n\nKokolo, Kokolo, Kokolo\nKokolo moj (ispod tog stojio potpis moj)\nKokolo, Kokolo, Kokolo\nKad si bio moj (onih dana kad je bio tvoj)\nKokolo, Kokolo, Kokolo\nKokolo moj (ispod tog stojio potpis moj)\nKokolo, Kokolo, Kokolo\nKad si bio moj\n\nTo to to si mi nekad šaputao la la la la la, la la la la la la\nSad sad sada bi mogli vratit one dane kad smo bili sretniiii...\n\nKokolo, Kokolo, Kokolo\nKokolo moj (ispod tog stojio potpis moj)\nKokolo, Kokolo, Kokolo\nKad si bio moj (onih dana kad je bio tvoj)\nKokolo, Kokolo, Kokolo\nKokolo moj (ispod tog stojio potpis moj)\nKokolo, Kokolo, Kokolo\nKad si bio moj\nKokolo moj, kad si bio moj\nKokolo moj, kad si bio moj\nKokolo moj, kada sam bio samo\n\nKokolo, Kokolo, Kokolo\nKokolo moj (ispod tog stojio potpis moj)\nKokolo, Kokolo, Kokolo\nKad si bio moj\nKokolo moj, kad si bio moj\nKokolo moj, kada sam bio samo\n\nKokolo, Kokolo, Kokolo\nKokolo moj (ispod tog stojio potpis moj)\nKokolo, Kokolo, Kokolo\nKad si bio moj\nKokolo moj, kad si bio moj\nKokolo moj, kad si bio moj\nKokolo moj, kada sam bio samo\n\nKokolo moj, kad si bio moj\nKokolo moj, kad si bio moj\nKokolo moj, kada sam bio samo	\N	6	Domaće	nan	0	nan	repertoar	\N	2026-03-11 12:43:09.130888	\N
130	Ako poludim	Magazin	H	Srednja	Zabavno	Hrvatska	Žensko	I u dobru i u zlu\nLjudi jedva čekaju\nDa ti zemlju pomaknu\nGrijeh za srce zataknu\n\nNadaleko čuje se\nDa si brat od nevolje, nevolje\nAli, ali meni si\nMed i mlijeko ljubavi\n\nAko poludim i pođem za tebe\nReći će ljudi sve o meni najgore\nJer ne znaju da ti za me bio si\nZa me bio si jedino jutro ljubavi\n\nAko poludim i pođem za tebe\nJer ne znaju da ti za me bio si\nZa me bio si jedino jutro ljubavi\n\nStavi ruku na mene\nDa me prođu brige sve\nRuka tvoja miluje\nNosi prst od sudbine\n\nNadaleko čuje se\nDa si brat od nevolje, nevolje\nAli, ali meni si\nMed i mlijeko ljubavi\n\nAko poludim i pođem za tebe\nReći će ljudi sve o meni najgore\nJer ne znaju da ti za me bio si\nZa me bio si jedino jutro ljubavi\n\nAko poludim i pođem za tebe\nReći će ljudi sve o meni najgore\nJer ne znaju da ti za me bio si\nZa me bio si jedino jutro ljubavi\n\nZa me bio si jedino jutro ljubavi	\N	7	Domaće	nan	0	nan	repertoar	\N	2026-03-11 12:43:09.130888	\N
131	Ja pijem da zaboravim	Gazde	Gism	Srednja	Tambure	Hrvatska	Muško	Od tebe sam, mala, bjezao\nbez tebe sam budan lezao\nzbog tebe sam sto zivota tudjih slomio\nal' od sebe nisam pobjeg'o\n\nTvoje srce cisto, nevino\npriznajem da nisam shvatio\nja sam htio puno vise, ruzu ubrati\nti me nisi mogla pratiti\n\nRef. 2x\nJa pijem da zaboravim\nja kockam da se umorim\nmoj je broj odavno pao\nkad sam tebe upoznao\nal' to tada nisam shvatio\n\nNe gledaj me da ne poludim\njos bi mog'o sve da pokvarim\nsad si ista kao i ja, idu godine\nbudi s drugim, budi bez mene\n\nRef.	\N	8	Domaće	nan	0	nan	repertoar	\N	2026-03-11 12:43:09.130888	\N
139	Ja sam za ples	Novi Fosili	G	Brza	Zabavno	Ex-Yu	Žensko	I wanna dance! O ho...\r\nJa sam za ples! O je...\r\n\r\nU nekom bistrou kod nas na moru ja pila sam sok\r\nA tamo za barom, na đuboksu starom su svirali rock\r\nOdjednom se stvori, ja čujem govori, "this is okay"\r\nPogled mi sretne, i kaže mi hej...\r\n\r\nČujem nešto kao "do you wanna dance"\r\nMislim da me pita da li sam za ples\r\nI wanna dance! O ho...\r\nJa sam za ples! O je...\r\n\r\nU nekom bistrou kod nas na moru ja pila sam sok\r\nA dolje na plaži su momci na gaži svirali rock\r\nI opet se stvori, ja čujem govori, "this is okay"\r\nPogled mi sretne, i kaže mi hej...	10	1	Domaće		0	\N	repertoar	\N	2026-03-12 11:28:48.068074	KICK I GIT INTRO\r\n\r\nI wanna dance! O ho...\r\nJa sam za ples! O je...\r\n\r\nU nekom bistrou kod nas na moru ja pila sam sok\r\nA tamo za barom, na đuboksu starom su svirali rock\r\nOdjednom se stvori, ja čujem govori, "this is okay"\r\nPogled mi sretne, i kaže mi hej...\r\n\r\nREF:2x\r\nČujem nešto kao "do you wanna dance"\r\nMislim da me pita da li sam za ples\r\nI wanna dance! O ho...\r\nJa sam za ples! O je...\r\n\r\nDRŽIMO (G) - ULAZ U IDUĆU
9	A šta da radim	Azra	Hm	Srednja	Pop / Rock	Ex-Yu	Žensko	A šta da radim kada odu prijatelji moji\r\nkada ode djevojka na koju bacam oči \r\n\r\nI tako redom dan za danom\r\nna javnim mjestima s gitarom\r\n\r\nNaravno da uvijek netko dođe\r\nda me čuje makar i kradom \r\n\r\nNišta mi više nije važno\r\nnašao sam dobar bend\r\nželim samo da sviram\r\nda se otkačim\r\ni to je sve \r\n\r\nA šta da radim kada odu prijatelji moji\r\nkada ode djevojka na koju bacam oči \r\n\r\nLjudi samo govore:\r\nzašto si nervozan\r\nLjudi samo pričaju:\r\nne budi tako grozan\r\n\r\nLjudske usne šapuću:\r\nšuljaj se ti kradom\r\nizbjegavaj nevolje\r\nskinut će ti glavu \r\n\r\nNišta mi više nije važno\r\nnašao sam dobar bend\r\nželim samo da sviram\r\nda se otkačim\r\ni to je sve \r\n\r\nA šta da radim kada odu prijatelji moji\r\nkada ode djevojka na koju bacam oči \r\n\r\nSolo\r\n\r\nNišta mi više nije važno\r\nnašao sam dobar bend\r\nželim samo da sviram\r\nda se otkačim\r\ni to je sve \r\n\r\nDa se otkačim i to je sve 3x	\N	1	Domaće		0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
124	Dalmatinka	Severina	G	Spora	Balada	Dalmacija	Žensko	Ja san bila tvoja mala\nI samo san za te cvala\nI sad kad san procvitala\nZbog tebe san zaplakala\n\nTi si i sad ruža moja\nAl ja nisan ljubav tvoja\nPreviše sam virovala\nLipoj riči od mornara\n\nDalmatinka, Dalmatinka\nTri ljubavi svoje ima\nPrva mi je Gospe moja\nDruga mi je ljubav tvoja\nA treća je bila moja\n\nTi si moja zvizda sjajna\nTi si moja prva tajna\nSićaš li se našeg žala\nDi sam tebi zakantala	\N	1	Domaće	nan	0	nan	repertoar	\N	2026-03-11 12:43:09.130888	\N
141	Tako je malo riječi palo	Novi Fosili	A	Srednja	Zabavno	Ex-Yu	Žensko	Tako je malo rijeci palo\r\nal' nije mi stalo, al' nije mi stalo\r\njer sutnjom se moze izreci vise\r\niskrenije puno, njeznije, tise\r\n\r\nTako je malo rijeci palo\r\nal' nije mi stalo, nije mi stalo\r\njer nisu rijeci one sto se pamte\r\njer nisu rijeci one sto traju\r\nkad jednom nadjes se na kraju\r\nrijeci se prve zaboravljaju\r\n\r\nKad jednom nadjes se na kraju\r\nrijeci se prve zaboravljaju	10	3	Domaće		0	\N	repertoar	\N	2026-03-12 11:33:18.903175	\N
142	Šuti moj dječače plavi	Novi Fosili	H	Srednja	Zabavno	Ex-Yu	Žensko	Iako davno su nestale sve veze što spajale su nas\r\nIako davno izbrisane su riječi i ne pamtim ti glas\r\nIako davno već zaborav te skrio i dodir tvoj je stran\r\nSusret bi novi probudio u meni onaj stari plan...\r\n\r\nAko te sretnem samo šuti, samo šuti, šuti moj dječače plavi,\r\nI nek tvoje kosa plava na jastuku uspomena spava...\r\nŠuti, samo šuti, šuti moj dječače plavi\r\nI nek tvoja kosa plava na jastuku uspomena spava...\r\n\r\nDugo već dugo pamtim te samo kao đački grijeh\r\nDugo već dugo ne znam dal su draže bile suze il smijeh\r\nDugo već dugo zaborav te skrio i dodir tvoj je stran\r\nAl susret bi novi probudio u meni onaj stari plan...\r\n\r\nŠuti, samo šuti, šuti moj dječače plavi...\r\n1 2 3 4 5 \r\n	10	4	Domaće		0	\N	repertoar	\N	2026-03-12 11:35:28.735877	\N
50	La Bamba	Richie Valens	C	Srednja	Pop / Rock	\N	Muško	2x sve\n\nPara bailar la bamba\nPara bailar la bamba\nSe necesita\nUna poca de gracia\nUna poca de gracia\nPara mi pa ti\n\nY arriba y arriba\nAy arriba y arriba\nPor ti seré, por ti seré, por ti seré\nYo no soy marinero\nYo no soy marinero\nSoy capitán, soy capitán, soy capitán\n\nBamba, bamba\n\nBamba, bamba\n\nBamba, bamba\n\nBamba\n\nMarko solo	5	1	Strano	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
51	Sviđa mi se ova stvar	Crvena Jabuka	C	Srednja	Pop / Rock	Ex-Yu	Muško	Svidja mi se ova stvar\nStaru ceznju budi mi\nSvidja mi se ova stvar\nNoc je vrela, vrela ti\nHajde mala daj mi daj\nTako njezna ostani\n\nSvidja mi se ova stvar\nStaru ceznju budi mi\nJa ne spavam nocima\nTi si moje slatko zlo\nPozuda u ocima\nDaj odvrni radio\n\nJer svidja mi se ova stvar\nBudi stare ljubavi\nPritisle su godine\nDal' ces sa mnom ostati\n\nBas je dobar ritam taj\nMogli bi zaplesati\nI ja sam k'o barut suh\nLahko me zapaliti\n\nSvidja mi se ova stvar\nStaru ceznju probudi mi\nDaj odvrni radio\nDa komsiluk poludi\nSvidja mi se ova stvar	5	2	Domaće	\N	0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
132	Moj je Dado puno radio	TS Zvona	E	Brza	Tambure	Slavonija	Muško	Moj je dado puno radio\na ja samo novce trosio\nja k'o gazda, on k'o sluga\nsad imamo zbog tog duga\nmoj je dado puno radio\n\nKada zorom sunce osvane\nmene svirci kuci doprate\npet sviraca mene prati\n'ajde, dado, ti im plati\nnis' me valjda dzabe pratili\n\nKaze dado - 'ajmo raditi\nvaljalo bi zito kositi\npusti, dado, zito, sijeno\nbas je vruce, cudo jedno\n'ajmo, dado, stogod popiti\n\nDok je meni dade u kuci\nu zivotu nis' me ne muci\ndado radi, meni daje\nsto je lipo neka traje\nda se dadi sto god ne desi	\N	9	Domaće	nan	0	nan	repertoar	\N	2026-03-11 12:43:09.130888	\N
98	Tvoje tijelo	Tony Cetinski	Am	Brza	Funky	Hrvatska	Muško	Ref. 2x\r\nMogli bi bilo gdje\r\nMoze samo daj mi sve\r\nOva noc luda je\r\nStvorena za dodire\r\nBejbe, bejbe\r\nO da si barem malo tu kraj mene ti\r\n\r\nInstrumental uvod\r\n\r\nJa nocas trebam tvoje tijelo\r\nJos nikad nisam bio tako sam\r\nMoje bi tijelo tvoje tijelo\r\nJa imam tako mnogo da ti dam\r\n\r\nI kad bi barem ovdje bila ti\r\nMi bi se cijele noci igrali\r\nO kad bi ovdje bila ti\r\nMi ne bi cijele noci zaspali\r\n\r\nRef. 2x\r\nMogli bi bilo gdje\r\nMoze samo daj mi sve\r\nOva noc luda je\r\nStvorena za dodire\r\nBejbe, bejbe\r\nO da si barem malo\r\nTu kraj mene ti\r\n\r\n2x Budi kraj mene ti\r\nKraj mene ti\r\nBudi kraj mene ti\r\nUvijek, uvijek\r\n\r\nKraj mene ti\r\nKraj mene ti\r\nUvijek, o da si tu kraj mene ti\r\n(o da si barem malo tu kraj mene ti)	\N	\N	Domaće		0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
34	Footloose	Kenny Loginns	A	Brza	Pop / Rock	\N	Muško	INTRO GIT\r\n\r\nVER:\r\nBeen working so hard\r\nI'm punching my card\r\nEight hours for what\r\nOh, tell me what I got\r\n\r\nBRIDGE:\r\nI've got this feeling\r\nThat times are holding me down\r\nI'll hit the ceiling\r\nOr else I'll tear up this town\r\n\r\nREF:\r\nNow I gotta cut loose, footloose\r\nKick off your Sunday shoes\r\nPlease, Louise, pull me off of my knees\r\nJack, get back, come on before we crack\r\nLose your blues, everybody cut footloose\r\n\r\nGIT RIFF(2bars)\r\n\r\nVER:\r\nYou're playing so cool\r\nObeying every rule\r\nDeep way down in your heart\r\nYou're burning yearning for some\r\n\r\nBRIDGE:\r\nSomebody to tell you\r\nThat life ain't passing you by\r\nI'm trying to tell you\r\nIt will if you don't even try\r\n\r\nREF:\r\nYou can fly\r\nif you'd only cut loose, footloose\r\nKick off your Sunday shoes\r\nOo-wee, Marie, shake it, shake it for me\r\nWhoa, Milo, come on, come on let's go\r\nLose your blues, everybody cut footloose\r\n\r\nBREAK:\r\nYeah, ooooh-oh-oh\r\n(Cut footloose)\r\nYeah, ooooh-oh-oh\r\n(Cut footloose)\r\nYeah, ooooh-oh-oh\r\n(Cut footloose)\r\nOooooooooh\r\n\r\n(First) You've got to turn me around\r\n(Second) And put your feet on the ground\r\n(Third) Now take the hold of all\r\n\r\nREF:\r\nI'm turning it loose footloose,\r\nKick off your Sunday shoes\r\nPlease, Louise, pull me off of my knees\r\nJack, get back, come on before we crack\r\nLose your blues, everybody cut footloose\r\n\r\n(Footloose) footloose\r\nKick off your Sunday shoes\r\nPlease, Louise, pull me off of my knees\r\nJack, get back, come on before we crack\r\nLose your blues,\r\neverybody cut, everybody cut\r\nEverybody cut, everybody cut\r\nEverybody cut, everybody cut\r\n(Everybody) everybody cut footloose	\N	\N	Strano		0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
146	Vino na usnama	Vlado Kalember	G	Brza	Fešta	Dalmacija	Muško	Neka nas prate mudraci\r\nNe pitaj da li je grijeh\r\nMi ćemo noćas sretni\r\nProdati dušu za smijeh\r\nTvoje su riječi hladne\r\nA pogled topao, dug\r\nNe boj se nikad mene\r\nJa bit ću ti dobar drug\r\n\r\nVino na usnama\r\nNek noćas čuje se pjesma do Jadrana\r\nVino na usnama\r\nNek noćas znaju svi da si me opila\r\nVino na usnama\r\nNek noćas čuje se pjesma do Jadrana\r\nVino na usnama\r\nNek noćas znaju svi da si me opila\r\n\r\nTvoje su riječi hladne\r\nA pogled topao, dug\r\nNe boj se nikad mene\r\nJa bit ću ti dobar drug\r\n\r\nVino na usnama\r\nNek noćas čuje se pjesma do Jadrana\r\nVino na usnama\r\nNek noćas znaju svi da si me opila\r\nVino na usnama\r\nNek noćas čuje se pjesma do Jadrana\r\nVino na usnama\r\nNek noćas znaju svi da si me opila\r\nVino na usnama\r\nNek noćas čuje se pjesma do Jadrana\r\nVino na usnama\r\nNek noćas znaju svi da si me opila\r\nVino na usnama\r\nNek noćas čuje se pjesma do Jadrana\r\nVino na usnama\r\nNek noćas znaju svi da si me opila\r\nVino na usnama\r\nNek noćas čuje se pjesma do Jadrana\r\nVino na usnama	12	5	Domaće		0	\N	repertoar	\N	2026-03-28 09:32:19.247456	Refren 2x\r\nVino na usnama\r\nNek noćas čuje se pjesma do Jadrana\r\nVino na usnama\r\nNek noćas znaju svi da si me opila\r\n\r\nInstrumental 1x\r\n
149	Zadnja želja	Miroslav Škoro	C	Spora	Balada	Hrvatska	Muško	Samo s tobom sve sam imao\r\nSve imao pa izgubio\r\nSad se kajem, ali kasno je\r\nTvoje kose drugi miluje\r\n\r\nA ti, da se vratiš ti\r\nDa još jednom ja te vidim\r\nDa me barem na tren zagrliš\r\nJa, sve bi dao ja\r\nDa mi dođeš i poljubiš\r\nDa mi zadnju želju ispuniš\r\n\r\nOd kad više nisi kraj mene\r\nU mom srcu tuga stanuje\r\nBoga molim da me pozove\r\nŠto će meni život bez tebe\r\n\r\nA ti, da se vratiš ti\r\nDa još jednom ja te vidim\r\nDa me barem na tren zagrliš\r\nJa, sve bi dao ja\r\nDa mi dođeš i poljubiš\r\nDa mi zadnju želju ispuniš\r\n\r\nA ti, da se vratiš ti\r\nDa još jednom ja te vidim\r\nDa me barem na tren zagrliš\r\nJa, sve bi dao ja\r\nDa mi dođeš i poljubiš	\N	\N	Domaće		0	\N	repertoar	\N	2026-03-28 09:50:10.034739	\N
143	TESTNA	Marko	G	Spora	Fešta	Hrvatska	Žensko	Neznam nesto je u oko upalo\r\ni da, jebiga..... XD	\N	1	Domaće		0	\N	repertoar	\N	2026-03-21 11:27:00.167546	Neznam nesto je u oko upalo\r\ni da, jebiga..... XD
20	Dajem ti rič	Dalmatino	H	Srednja	Zabavno	Dalmacija	Muško	Ja u obe ruke cvrsto drzin konce\r\njer za sve sta vaja moras imat force\r\nza veliku jubav mos prilit more\r\niz skrape u skrapu pa nek kazu da sam lud\r\n\r\nA u desnoj ruci donosim ti srce\r\nca ni jednoj dosad nikad nisan da\r\nta jubav ca se cidi ispod tvoga oka\r\nto znaci da vridida je previse duboka\r\n\r\nRef.\r\nNevrime i nesrica nece na nas nikada\r\ndodje li jedna tvoja suza do neba\r\nslidin tvoje korake rukan tiran oblake\r\ni dajem ti ric da s tobom cu ic ravno prid Boga\r\n\r\nKad se miljun zvizda prospe ka iz bajke\r\nlini misec zaspe na srid kale puste\r\nstat cemo goli ka rodjeni od majke\r\nti mi ne dozvolida ti pobignem kroz prste\r\n\r\nRef. 2x	\N	\N	Domaće		0	\N	repertoar	\N	2026-03-11 12:43:09.130888	\N
140	E moj Saša	Novi Fosili	G	Srednja	Zabavno	Ex-Yu	Žensko	E, moj Saša, e moj Saša\r\nGdje je sada ljubav naša\r\nReci Saša e, moj Saša\r\nZnaš li gdje je ljubav naša\r\nI da li pamtiš zadnje ljeto\r\nSrcu mom još tako sveto\r\nE, moj Saša\r\n\r\nTi imaš stan i krasnog klinca\r\nPosao stalan i kućnog mezinca\r\nSretan brak i dobar glas\r\nAl' nemaš više nas\r\n\r\nTi imaš auto i krug prijatelja\r\nOmiljen hobi i sitna veselja\r\nGodine mlade i vitak stas\r\nAl' nemaš više nas\r\n\r\nE, moj Saša, e moj Saša\r\nGdje je sada ljubav naša\r\nReci Saša e, moj Saša\r\nZnaš li gdje je ljubav naša\r\nI da li pamtiš zadnje ljeto\r\nSrcu mom još tako sveto\r\nE, moj Saša, e moj Saša\r\nGdje je sada ljubav naša\r\nReci Saša e, moj Saša\r\nZnaš li gdje je ljubav naša\r\nTi život grabiš, al za mene\r\nOstale tek su uspomene\r\nE, moj Saša\r\n\r\nTi imaš sijanje i honorare\r\nVremena malo za slike stare\r\nI televizor kao spas\r\nAl' nemaš više nas	10	2	Domaće		0	\N	repertoar	\N	2026-03-12 11:31:57.065347	Ti imaš stan i krasnog klinca\r\nPosao stalan i kućnog mezinca\r\nSretan brak i dobar glas\r\nAl' nemaš više nas\r\n\r\nTi imaš auto i krug prijatelja\r\nOmiljen hobi i sitna veselja\r\nGodine mlade i vitak stas\r\nAl' nemaš više nas\r\n\r\nE, moj Saša, e moj Saša\r\nGdje je sada ljubav naša\r\nReci Saša e, moj Saša\r\nZnaš li gdje je ljubav naša\r\nI da li pamtiš zadnje ljeto\r\nSrcu mom još tako sveto\r\nE, moj Saša, e moj Saša\r\nGdje je sada ljubav naša\r\nReci Saša e, moj Saša\r\nZnaš li gdje je ljubav naša\r\nTi život grabiš, al za mene\r\nOstale tek su uspomene\r\nE, moj Saša\r\n\r\nPREKO (E) u (A) - na iza Saša\r\n\r\n
145	Srdela	Doris Dragović	G	Brza	Fešta	Dalmacija	Muško	U konobi staroj\r\nnasli smo se svi\r\nprijatelji dragi\r\ndosli slaviti\r\nsrdele su slane\r\nvino rumeno\r\nobicaje nase stare stujemo\r\njer kada se slavi\r\nonda se pjeva\r\nnek' ide spavat kome se zjeva\r\nmi cemo ovdje\r\ndo jutra ostati\r\nkada se slavi onda se pije\r\nnek' ide spavat\r\nko za to nije\r\nmi cemo ovdje\r\ndo jutra ostati\r\n\r\nu zoru te , u zoru te\r\nzabolila glava\r\nsrdela ti naskodila\r\njer je riba plava\r\nnije kriva s r d e l a\r\nsto je riba plava\r\nvec od vina rumena\r\ntebe boli glava\r\nu zoru te , u zoru te\r\nzabolila glava\r\nsrdela ti naskodila\r\njer je riba plava\r\nnije kriva s r d e l a\r\nsto je riba plava\r\nvec od vina rumena\r\ntebe boli glava\r\n\r\nu konobi staroj\r\nstruje nestalo\r\nal' ne treba ti struja\r\nda bi se pjevao\r\nu konobi staroj\r\nvode nestalo\r\nsve dok ima vina\r\nvode necemo\r\njer kada se slavi\r\nonda se pjeva\r\nnek' ide spavat\r\nkome se zjeva\r\nmi cemo ovdje\r\ndo jutra ostati\r\n\r\nu zoru te , u zoru te\r\nzabolila glava\r\nsrdela ti naskodila\r\njer je riba plava\r\nnije kriva s r d e l a\r\nsto je riba plava\r\nvec od vina rumena\r\ntebe boli glava\r\nu zoru te , u zoru te\r\nzabolila glava\r\nsrdela ti naskodila\r\njer je riba plava\r\nnije kriva s r d e l a\r\nsto je riba plava\r\nvec od vina rumena\r\ntebe boli glava\r\n\r\nnije kriva s r d e l a\r\nsto je riba plava\r\nvec od vina rumena\r\ntebe boli glava !	12	4	Domaće		0	\N	repertoar	\N	2026-03-28 09:30:33.372957	I jedan i dva i tri pa kaže,\r\n\r\nRefren\r\nU zoru te u zoru te zabolila glava\r\nSrdela ti naškodila jer je riba plava\r\nMa nije kriva srdela što je riba plava\r\nVeć od vina rumena tebe boli glava\r\n\r\nInstrumental 1x\r\n\r\nPazi sada jedan pa dva pa tri pa kaže\r\n
147	Ništa kontra Splita	Dino Dvornik	G	Brza	Fešta	Dalmacija	Muško	ucer su opet letile boce\r\novi put nije bilo zbog Coce\r\nsvud okolo kole bilo je stakla\r\nnije zbog Danijele, nije zbog brata\r\n\r\nIz cista mira me vatija tip\r\ni pocea vridjat' u lokalu\r\nka da on ne voli moju glazbu\r\ni neka lipo idem k vragu\r\n\r\nA ja san sve trpija i mucija\r\niskustvo je reklo, bit' ce tuca\r\ncinija san fintu da me nije briga\r\ndok mi nije pocea i Split spominjat'\r\n\r\nOnda je meni skocia zivac\r\ntip me tia isprovocirat'\r\ni onda sam mu zapiva sve po spisku\r\nnek' cuje papan bestimju splitsku\r\n\r\nRef. 2x\r\nTi mos govorit' kontra mene\r\ni kontra cilog svita\r\nma necu da cujen nista\r\nnista kontra Splita\r\n\r\nI tako je onda pocela tuca\r\nbila je prava luda kuca\r\nkatrige su letile medju svit\r\ni onda su se tako umisali svi\r\n\r\nI nisan tija, ispalo je tako\r\nna njegovu jednu, posla san ga u tri\r\na moglo je isto sve lipse zavrsit'\r\nda mi nije na kraju spominia Split\r\n\r\nRef. 2x\r\n\r\nDino je ovaki, Dino je onaki\r\nposli su tako govorili svi\r\nDino je opet ispa kriv\r\ni bit' ce kriv dok je ziv\r\n\r\nRef. 2x	12	6	Domaće		0	\N	repertoar	\N	2026-03-28 09:33:41.671376	Refren 2x\r\nMoš govorit kontra mene i kontra cilog svita\r\nAl neću da čujem ništa ništa kontra Splita\r\n\r\nKraj\r\n
144	Neka neka nek se zna	Tomislav Ivčić	G	Brza	Fešta	Dalmacija	Muško	Zasto me lazes\r\nzasto me mucis\r\nides u kino\r\na kazes da ucis\r\n\r\nZasto me mucis\r\nzasto me lazes\r\nopet te nema\r\niako kazes\r\n\r\nNe mogu ti nikad\r\nreci sve sto hocu\r\nne vidjam te cesto\r\npa te sanjam nocu, nocu, nocu\r\n\r\nRef.\r\nNeka neka nek se zna\r\nvolio sam samo ja\r\na ti si se poigrala\r\nza tebe je ljubav sala\r\nneka, neka, nek se zna\r\n\r\nCekam te pred skolom\r\nzelim da te pratim\r\nal' uvijek tako\r\nsam se kuci vratim\r\n\r\nS nekim uvijek pricas\r\nkad ti zelim prici\r\ndo tvoga srca\r\nnikad necu stici\r\n\r\nRef. 2x	12	3	Domaće		0	\N	repertoar	\N	2026-03-28 09:29:01.889936	Odmah\r\n\r\nVerse\r\nZašto me lažeš, zašto me mučiš\r\nIdeš u kino a kažeš da upiše\r\nZašto me mučiš, zašto me lažeš\r\nOpet te nema iako kažeš\r\n\r\nNe mogu ti nikad reći sve što hoću\r\nNe viđam te često pa te sanjam noćuuuu\r\n\r\nRefren\r\nNeka neka neka se zna,\r\nVolio sam samo ja\r\nA ti si se poigrala,\r\nZa tebe je ljubav šala\r\nNeka neka neka se zna 2x\r\n\r\nInstrumental 1x\r\n
56	Da nije ljubavi	Crvena Jabuka	G	Srednja	Pop / Rock	Ex-Yu	Muško	Ispali mi jedno tri sunčana ljeta u sljepoočnicu\r\nTvoja priča me udavi, počet ću da vjerujem u ublehu\r\nA ublehu su stvorili čuvari tvojih želja, kraljice, hej\r\n\r\nTo drvo šumu zakloni, još više me zabolješe\r\nPretkomora lijeva i desna, od duše i od srca\r\nTebi postelja bješe tijesna, pa si me izgurala\r\nVidi nemoći, teško je obići, pjesma će poteći\r\n\r\n(Je'n, dva, tri, i)\r\nDa nije ljubavi, da nije ljubavi\r\nDa nije ljubavi, ne bi svita bilo\r\nNi mene, ni tebe, ni mene, ni tebe\r\nNi mene, ni tebe, moja bajna vilo\r\n\r\nInstrumental\r\n\r\nIspali mi jedno tri sunčana ljeta u sljepoočnicu\r\nTvoja priča me udavi, počet ću da vjerujem u ublehu\r\nA ublehu su stvorili čuvari tvojih želja, kraljice, hej\r\nTo drvo šumu zakloni, još više me zabolješe\r\nPretkomora lijeva i desna, od duše i od srca\r\nTebi postelja bješe tijesna, pa si me izgurala\r\nVidi nemoći, teško je obići, pjesma će poteći\r\n\r\nRef. 2x\r\n(Je'n, dva, tri, i)\r\nDa nije ljubavi, da nije ljubavi\r\nDa nije ljubavi, ne bi svita bilo\r\nNi mene, ni tebe, ni mene, ni tebe\r\nNi mene, ni tebe, moja bajna vilo	12	2	Domaće		0	\N	repertoar		2026-03-11 12:43:09.130888	Pazi sad ovako, i jedan i dva i tri\r\n\r\nVerse\r\nDaaa (na 5.dobu) nije ljubavi da nije ljubavi\r\nDa (na 3. dobu) nije ljubavi ne bi svita bilo\r\nNi mene ni tebe ni mene ni tebe\r\nNi mene ni tebe moja bajna vilo\r\n\r\nInstrumental 1x\r\n\r\nNoćas mi se snilo noćas mi se snilo\r\nNoćas mi se snilo moja bajna vilo\r\nDa je moje tilo da je moje tilo\r\nDa je moje tilo kraj tvojega bilo\r\n\r\nInstrumental 1x\r\n
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: markomarjanovic
--

COPY public.users (id, email, role, is_active, created_at) FROM stdin;
\.


--
-- Name: mixes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: markomarjanovic
--

SELECT pg_catalog.setval('public.mixes_id_seq', 12, true);


--
-- Name: rehearsal_songs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: markomarjanovic
--

SELECT pg_catalog.setval('public.rehearsal_songs_id_seq', 72, true);


--
-- Name: rehearsals_id_seq; Type: SEQUENCE SET; Schema: public; Owner: markomarjanovic
--

SELECT pg_catalog.setval('public.rehearsals_id_seq', 3, true);


--
-- Name: setlist_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: markomarjanovic
--

SELECT pg_catalog.setval('public.setlist_items_id_seq', 15, true);


--
-- Name: setlists_id_seq; Type: SEQUENCE SET; Schema: public; Owner: markomarjanovic
--

SELECT pg_catalog.setval('public.setlists_id_seq', 3, true);


--
-- Name: songs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: markomarjanovic
--

SELECT pg_catalog.setval('public.songs_id_seq', 149, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: markomarjanovic
--

SELECT pg_catalog.setval('public.users_id_seq', 1, false);


--
-- Name: mixes idx_16390_mixes_pkey; Type: CONSTRAINT; Schema: public; Owner: markomarjanovic
--

ALTER TABLE ONLY public.mixes
    ADD CONSTRAINT idx_16390_mixes_pkey PRIMARY KEY (id);


--
-- Name: songs idx_16398_songs_pkey; Type: CONSTRAINT; Schema: public; Owner: markomarjanovic
--

ALTER TABLE ONLY public.songs
    ADD CONSTRAINT idx_16398_songs_pkey PRIMARY KEY (id);


--
-- Name: rehearsals idx_16408_rehearsals_pkey; Type: CONSTRAINT; Schema: public; Owner: markomarjanovic
--

ALTER TABLE ONLY public.rehearsals
    ADD CONSTRAINT idx_16408_rehearsals_pkey PRIMARY KEY (id);


--
-- Name: rehearsal_songs idx_16417_rehearsal_songs_pkey; Type: CONSTRAINT; Schema: public; Owner: markomarjanovic
--

ALTER TABLE ONLY public.rehearsal_songs
    ADD CONSTRAINT idx_16417_rehearsal_songs_pkey PRIMARY KEY (id);


--
-- Name: setlists idx_16423_setlists_pkey; Type: CONSTRAINT; Schema: public; Owner: markomarjanovic
--

ALTER TABLE ONLY public.setlists
    ADD CONSTRAINT idx_16423_setlists_pkey PRIMARY KEY (id);


--
-- Name: setlist_items idx_16431_setlist_items_pkey; Type: CONSTRAINT; Schema: public; Owner: markomarjanovic
--

ALTER TABLE ONLY public.setlist_items
    ADD CONSTRAINT idx_16431_setlist_items_pkey PRIMARY KEY (id);


--
-- Name: login_tokens login_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: markomarjanovic
--

ALTER TABLE ONLY public.login_tokens
    ADD CONSTRAINT login_tokens_pkey PRIMARY KEY (token);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: markomarjanovic
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: markomarjanovic
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: idx_songs_filters; Type: INDEX; Schema: public; Owner: markomarjanovic
--

CREATE INDEX idx_songs_filters ON public.songs USING btree (genre, region, vocal, origin, tempo);


--
-- Name: uniq_song_artist; Type: INDEX; Schema: public; Owner: markomarjanovic
--

CREATE UNIQUE INDEX uniq_song_artist ON public.songs USING btree (lower(TRIM(BOTH FROM title)), lower(TRIM(BOTH FROM artist)));


--
-- Name: login_tokens login_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: markomarjanovic
--

ALTER TABLE ONLY public.login_tokens
    ADD CONSTRAINT login_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: rehearsal_songs rehearsal_songs_rehearsal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: markomarjanovic
--

ALTER TABLE ONLY public.rehearsal_songs
    ADD CONSTRAINT rehearsal_songs_rehearsal_id_fkey FOREIGN KEY (rehearsal_id) REFERENCES public.rehearsals(id);


--
-- Name: rehearsal_songs rehearsal_songs_song_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: markomarjanovic
--

ALTER TABLE ONLY public.rehearsal_songs
    ADD CONSTRAINT rehearsal_songs_song_id_fkey FOREIGN KEY (song_id) REFERENCES public.songs(id);


--
-- Name: setlist_items setlist_items_setlist_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: markomarjanovic
--

ALTER TABLE ONLY public.setlist_items
    ADD CONSTRAINT setlist_items_setlist_id_fkey FOREIGN KEY (setlist_id) REFERENCES public.setlists(id);


--
-- Name: songs songs_mix_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: markomarjanovic
--

ALTER TABLE ONLY public.songs
    ADD CONSTRAINT songs_mix_id_fkey FOREIGN KEY (mix_id) REFERENCES public.mixes(id);


--
-- PostgreSQL database dump complete
--

\unrestrict w7fnqReZpHlyr7a651wegmV2mo42YFVqkfbKC5rrcK17hn9ammg5T4KSdLKaJ5z

