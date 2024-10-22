begin transaction;

-- creazione dei domini

create domain String as varchar;

create domain StringNotNull as varchar
    check (value is not null);

create domain Civico as varchar
    check (value ~ '[0-9]+(/[a-z]+)?');

create domain CAP as varchar
    check (value ~ '[0-9]{5}' and value is not null);

create domain CodFis as varchar(16);

create domain PosInteger as integer
    check (value >= 0);

create domain Targa as varchar(8);

create type Indirizzo as (
    via StringNotNull,
    civico Civico,
    cap CAP
);

-- creazione dello schema relazionale

create table Nazione (
    nome StringNotNull,
    primary key(nome)
);

create table Regione (
    nome StringNotNull,
    nazione StringNotNull,
    primary key (nome, nazione),
    foreign key (nazione) references Nazione(nome)
);

create table Citta (
    nome StringNotNull,
    regione StringNotNull,
    nazione StringNotNull,
    primary key (nome, regione),
    foreign key (regione,nazione) references Regione(nome, nazione)
);

create table Marca (
    nome StringNotNull,
    primary key (nome)
);

create table TipoVeicolo (
    nome StringNotNull,
    primary key (nome)
);

create table Modello (
    nome StringNotNull,
    marca StringNotNull,
    tipoveicolo StringNotNull,
    primary key (nome, marca),
    foreign key (marca) references Marca(nome),
    foreign key (tipoveicolo) references TipoVeicolo(nome)
);

create table Veicolo (
    targa Targa not null,
    immatricolazione integer not null,
    cliente StringNotNull,
    modello StringNotNull,
    primary key (targa),
    foreign key (modello) references Modello(nome, marca),
    foreign key (cliente) references Cliente(persona)
);

create table Riparazione (
    codice posInteger not null,
    inizio timestamp not null,
    riconsegna timestamp,
    officina integer not null,
    veicolo Targa not null,
    primary key (codice),
    foreign key (officina) references Officina(id),
    foreign key (veicolo) references Veicolo(targa)
);

create table Persona (
    cf CodFis not null,
    nome StringNotNull,
    indirizzo Indirizzo not null,
    telefono varchar(20) not null,
    citta StringNotNull,
    primary key (cf),
    foreign key (citta) references Citta(nome, regione, nazione)
);

create table Cliente (
    persona CodFis not null,
    primary key (persona),
    foreign key (persona) references Persona(cf)
);

create table Staff (
    persona CodFis not null,
    primary key (persona),
    foreign key (persona) references Persona(cf)
);

create table Dipendente (
    staff CodFis not null,
    officina integer not null,
    primary key (staff),
    foreign key (officina) references Officina(id),
);

create table Direttore (
    staff CodFis not null,
    nascita date not null,
    primary key (staff),
    foreign key (staff) references Staff(persona)
);

create table Lavorare (
    dipendente CodFis not null,
    id Integer not null,
    assunzione date not null,
    primary key (dipendente, id),
    foreign key (dipendente) references Dipendente(staff),
    foreign key (officina) references Officina(id)
);

create table Officina (
    id Integer not null,
    nome StringNotNull,
    indirizzo Indirizzo not null,
    direttore CodFis not null,
    citta StringNotNull,
    primary key (id),
    foreign key (direttore) references Direttore(staff),
    foreign key (citta) references Citta(nome, regione, nazione)
);

commit;