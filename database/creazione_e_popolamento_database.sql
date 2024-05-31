DROP DATABASE IF EXISTS GeekFactoryDB;
CREATE DATABASE GeekFactoryDB;

USE GeekFactoryDB;

DROP TABLE IF EXISTS UserAccount;
CREATE TABLE UserAccount (
    email VARCHAR(50) PRIMARY KEY NOT NULL,
    passwordUser VARCHAR(255) NOT NULL,
    nome VARCHAR(50) NOT NULL,
    cognome VARCHAR(50) NOT NULL,
    indirizzo VARCHAR(50) NOT NULL,
    telefono VARCHAR(15) NOT NULL,
    numero CHAR(16) NOT NULL,
    intestatario VARCHAR(50) NOT NULL,
    CVV CHAR(3) NOT NULL,
    ruolo VARCHAR(16) NOT NULL DEFAULT 'registeredUser'
);

DROP TABLE IF EXISTS Cliente;
CREATE TABLE Cliente (
    email VARCHAR(50) PRIMARY KEY NOT NULL,
    FOREIGN KEY (email) REFERENCES UserAccount(email) ON UPDATE CASCADE ON DELETE CASCADE
);

DROP TABLE IF EXISTS Venditore;
CREATE TABLE Venditore (
    email VARCHAR(50) PRIMARY KEY NOT NULL,
    feedback INT DEFAULT NULL,
    FOREIGN KEY (email) REFERENCES UserAccount(email) ON UPDATE CASCADE ON DELETE CASCADE
);

DROP TABLE IF EXISTS Tipologia;
CREATE TABLE Tipologia (
    nome ENUM('Arredamento Casa','Action Figures','Gadget') PRIMARY KEY NOT NULL
);

DROP TABLE IF EXISTS Prodotto;
CREATE TABLE Prodotto (
    codice INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    descrizione TEXT NOT NULL,
    deleted BOOL NOT NULL DEFAULT FALSE,
    prezzo DOUBLE(10,2) NOT NULL,
    model VARCHAR(200) NOT NULL,
    speseSpedizione DOUBLE(5,2) DEFAULT 0,
    emailVenditore VARCHAR(50) NOT NULL,
    tag ENUM('Manga/Anime', 'Film/Serie TV', 'Videogiochi', 'Originali') NOT NULL,
    nomeTipologia ENUM('Arredamento Casa','Action Figures','Gadget') NOT NULL,
    dataAnnuncio DATE NOT NULL,
    FOREIGN KEY (emailVenditore) REFERENCES Venditore(email) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (nomeTipologia) REFERENCES Tipologia(nome) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1000;

DROP TABLE IF EXISTS Ordine;
CREATE TABLE Ordine (
    codiceOrdine INT NOT NULL AUTO_INCREMENT,
    codiceProdotto INT NOT NULL,
    emailCliente VARCHAR(50) NOT NULL,
    prezzoTotale DOUBLE(10,2) NOT NULL,
    quantity INT NOT NULL,
    dataAcquisto DATE NOT NULL,
    PRIMARY KEY (codiceOrdine),
    FOREIGN KEY (codiceProdotto) REFERENCES Prodotto(codice) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (emailCliente) REFERENCES Cliente(email) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=100;

DROP TABLE IF EXISTS Recensione;
CREATE TABLE Recensione (
    codiceRecensione INT NOT NULL AUTO_INCREMENT,
    codiceProdotto INT NOT NULL,
    emailCliente VARCHAR(50) NOT NULL,
    votazione TINYINT UNSIGNED NOT NULL,
    testo TEXT,
    dataRecensione DATE NOT NULL,
    PRIMARY KEY (codiceRecensione),
    FOREIGN KEY (codiceProdotto) REFERENCES Prodotto(codice) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (emailCliente) REFERENCES Cliente(email) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1000;

DROP TABLE IF EXISTS Preferiti;
CREATE TABLE Preferiti (
    codiceProdotto INT NOT NULL,
    emailCliente VARCHAR(50) NOT NULL,
    PRIMARY KEY (codiceProdotto, emailCliente),
    FOREIGN KEY (codiceProdotto) REFERENCES Prodotto(codice) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (emailCliente) REFERENCES Cliente(email) ON UPDATE CASCADE ON DELETE CASCADE
);

USE GeekFactoryDB;

/* begin data population */

/* accountuser data */
INSERT INTO UserAccount (email, passwordUser, nome, cognome, indirizzo, telefono, numero, intestatario, CVV, ruolo)
VALUES ('geekfactory@gmail.com', SHA2('12345678', 256), 'Geek', 'Factory', 'Unisa, Dipartimento Informatica', '3476549862', '5436724598431234', 'GeekFactory', '476', 'admin');
INSERT INTO UserAccount (email, passwordUser, nome, cognome, indirizzo, telefono, numero, intestatario, CVV)
VALUES ('mariorossi@gmail.com', SHA2('12345678', 256), 'Mario', 'Rossi', 'Caserta, Via Lazio 14', '3476549862', '5436724598431234', 'Mario Rossi', '476'); 
INSERT INTO UserAccount (email, passwordUser, nome, cognome, indirizzo, telefono, numero, intestatario, CVV)
VALUES ('luigiverdi@gmail.com', SHA2('12345678', 256), 'Luigi', 'Verdi', 'Roma, Via Cesare 17', '3518457668', '6745982476311234', 'Luigi Verdi', '435'); 
INSERT INTO UserAccount (email, passwordUser, nome, cognome, indirizzo, telefono, numero, intestatario, CVV)
VALUES ('lorenzobianchi@gmail.com', SHA2('12345678', 256), 'Lorenzo', 'Bianchi', 'Messina, Via Federico Fellini 14', '3474351776', '8791267534971234', 'Lorenzo Bianchi', '143'); 
INSERT INTO UserAccount (email, passwordUser, nome, cognome, indirizzo, telefono, numero, intestatario, CVV)
VALUES ('gigiprossi@gmail.com', SHA2('12345678', 256), 'Gigi Pio', 'Rossi', 'Caserta, Via Lazio 14', '3518234671', '7613872515281234', 'Gigi Pio Rossi', '621'); 
INSERT INTO UserAccount (email, passwordUser, nome, cognome, indirizzo, telefono, numero, intestatario, CVV)
VALUES ('davidesari@yahoo.com', SHA2('12345678', 256), 'Davide', 'Sari', 'Palermo, Via Libertà 15', '3517628334', '8901034567391234', 'Davide Sari', '165'); 
INSERT INTO UserAccount (email, passwordUser, nome, cognome, indirizzo, telefono, numero, intestatario, CVV)
VALUES ('emildcarlo@libero.it', SHA2('12345678', 256), 'Emiliano', 'De Carlo', 'Napoli, Via Superiore 24', '3479228888', '3241768501101234', 'Emiliano De Carlo', '823'); 
INSERT INTO UserAccount (email, passwordUser, nome, cognome, indirizzo, telefono, numero, intestatario, CVV)
VALUES ('saraverdi@gmail.com', SHA2('12345678', 256), 'Sara', 'Verdi', 'Pisa, Via Miracoli 73', '3476629882', '6734891203451234', 'Sara Verdi', '820'); 
INSERT INTO UserAccount (email, passwordUser, nome, cognome, indirizzo, telefono, numero, intestatario, CVV)
VALUES ('federeale@yahoo.com', SHA2('12345678', 256), 'Federica', 'Reale', 'Salerno, Via Ponzi 1', '3471192332', '8923674123781234', 'Federica Reale', '732'); 
INSERT INTO UserAccount (email, passwordUser, nome, cognome, indirizzo, telefono, numero, intestatario, CVV)
VALUES ('cr7@gmail.com', SHA2('4567812', 256), 'Cristiano', 'Ronaldo', 'Torino, Via Gemma 34', '3519938471', '7639071056291234', 'Cristiano Ronaldo', '623'); 
INSERT INTO UserAccount (email, passwordUser, nome, cognome, indirizzo, telefono, numero, intestatario, CVV)
VALUES ('simonebianchi@yahoo.com', SHA2('12345678', 256), 'Simone', 'Bianchi', 'Sorrento, Via Alighieri 23', '3476593456', '7869823489011234', 'Simone Bianchi', '168'); 
INSERT INTO UserAccount (email, passwordUser, nome, cognome, indirizzo, telefono, numero, intestatario, CVV)
VALUES ('alfredopirlo@libero.it', SHA2('12345678', 256), 'Alfredo', 'Pirlo', 'Torino, Via La Spina 90', '3491112398', '9182034856721234', 'Alfredo Pirlo', '182'); 
INSERT INTO UserAccount (email, passwordUser, nome, cognome, indirizzo, telefono, numero, intestatario, CVV)
VALUES ('gigiboni@gmail.com', SHA2('12345678', 256), 'Luigi', 'Boni', 'Pescara, Via Roma 4', '3519821234', '7328461970211234', 'Luigi Boni', '129'); 
INSERT INTO UserAccount (email, passwordUser, nome, cognome, indirizzo, telefono, numero, intestatario, CVV)
VALUES ('tonytranchese@gmail.com', SHA2('12345678', 256), 'Antonio', 'Tranchese', 'Roma, Via Da Vinci 7', '3429812345', '8632904712391234', 'Antonio Tranchese', '918');

-- Cliente Data
INSERT INTO Cliente (email)
VALUES 
('mariorossi@gmail.com'), 
('luigiverdi@gmail.com'), 
('lorenzobianchi@gmail.com'), 
('gigiprossi@gmail.com'), 
('davidesari@yahoo.com'), 
('emildcarlo@libero.it'), 
('saraverdi@gmail.com'), 
('federeale@yahoo.com'), 
('cr7@gmail.com'), 
('simonebianchi@yahoo.com'), 
('alfredopirlo@libero.it'), 
('gigiboni@gmail.com'), 
('tonytranchese@gmail.com');

-- Venditore Data
INSERT INTO Venditore (email, feedback)
VALUES 
('mariorossi@gmail.com', NULL), 
('luigiverdi@gmail.com', NULL), 
('lorenzobianchi@gmail.com', NULL), 
('gigiprossi@gmail.com', NULL), 
('davidesari@yahoo.com', NULL), 
('emildcarlo@libero.it', NULL), 
('saraverdi@gmail.com', NULL), 
('federeale@yahoo.com', NULL), 
('cr7@gmail.com', NULL), 
('simonebianchi@yahoo.com', NULL), 
('alfredopirlo@libero.it', NULL), 
('gigiboni@gmail.com', NULL), 
('tonytranchese@gmail.com', NULL);

-- Tipologia Data
INSERT INTO Tipologia (nome)
VALUES ('Arredamento Casa'), ('Action Figures'), ('Gadget');

-- Prodotto Data
INSERT INTO Prodotto (codice, nome, descrizione, prezzo, model, speseSpedizione, emailVenditore, tag, nomeTipologia, dataAnnuncio)
VALUES 
(1000, 'Tavolo Trasformabile', 'Tavolo moderno che può trasformarsi in vari mobili.', 299.99, 'tavolo_trasformabile_model.obj', 15.99, 'mariorossi@gmail.com', 'Arredamento Casa', 'Arredamento Casa', '2023-05-01'),
(1001, 'Figura Goku Super Saiyan', 'Action figure dettagliata di Goku nella forma Super Saiyan.', 49.99, 'goku_ssj_model.obj', 5.99, 'luigiverdi@gmail.com', 'Manga/Anime', 'Action Figures', '2023-05-10'),
(1002, 'Lampada Iron Man', 'Lampada a forma di casco di Iron Man.', 24.99, 'lampada_iron_man_model.obj', 3.99, 'lorenzobianchi@gmail.com', 'Film/Serie TV', 'Gadget', '2023-05-15');

-- Ordine Data
INSERT INTO Ordine (codiceProdotto, emailCliente, prezzoTotale, quantity, dataAcquisto)
VALUES 
(1000, 'davidesari@yahoo.com', 315.98, 1, '2023-06-01'),
(1001, 'saraverdi@gmail.com', 55.98, 1, '2023-06-05'),
(1002, 'federeale@yahoo.com', 28.98, 1, '2023-06-10');

-- Recensione Data
INSERT INTO Recensione (codiceProdotto, emailCliente, votazione, testo, dataRecensione)
VALUES 
(1000, 'davidesari@yahoo.com', 5, 'Prodotto fantastico!', '2023-06-15'),
(1001, 'saraverdi@gmail.com', 4, 'Molto soddisfatta dell\'acquisto.', '2023-06-20'),
(1002, 'federeale@yahoo.com', 3, 'Buon prodotto, ma spese di spedizione elevate.', '2023-06-25');

-- Preferiti Data
INSERT INTO Preferiti (codiceProdotto, emailCliente)
VALUES 
(1000, 'mariorossi@gmail.com'), 
(1001, 'luigiverdi@gmail.com'), 
(1002, 'lorenzobianchi@gmail.com');
