begin transaction;

-- creazione dei domini
create type Denaro as (
    valuta varchar(3),
    importo real > 0
);

create type Indrizzo as (
    via varchar(50),
    civico varchar(5),
    cap varchar(5)
);

create domain CF as varchar(16);

create domain PosInt as integer check (value > 0)

-- creazione dello schema relazionale

create table TipologiaSpettacolo(
    nome varchar(100) not null,
    primary key (nome)
);

create table GenereSpettacolo(
    nome varchar(100) not null,
    primary key (nome)
);

create table Spettacolo(
    titolo varchar(100) not null,
    durata PosInt not null,
    genere varchar(100) not null,
    tipologia varchar(100) not null,
    primary key (titolo, genere)
    foreign key (genere) references GenereSpettacolo(nome)
    foreign key (tipologia) references TipologiaSpettacolo(nome)
);