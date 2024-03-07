CREATE TABLE toiduaine(
    toiduaine_id int PRIMARY KEY AUTO_INCREMENT,
    toiduaine_nimi varchar(100));

CREATE TABLE yhik(
    yhik_id int PRIMARY KEY AUTO_INCREMENT,
    yhik_nimi varchar(100));
    
CREATE TABLE koostis(
    koostis_id int PRIMARY KEY AUTO_INCREMENT,
    kogus int,
    retsept_retsept_ID int,
    toiduaine_ID int,
    yhik_ID int,
    FOREIGN KEY (toiduaine_ID) REFERENCES toiduaine(toiduaine_ID)
    FOREIGN KEY (yhik_ID) REFERENCES yhik(yhik_ID));

CREATE TABLE kasutaja(
    tkasutaja_id int PRIMARY KEY AUTO_INCREMENT,
    eesnimi varchar(50)
    perenimi varchar(50)
    email varchar(150));

CREATE TABLE kategooria(
    kategooria_id int PRIMARY KEY AUTO_INCREMENT,
    kategooria_nimi varchar(50));

CREATE TABLE retsept(
    retsept_ID int PRIMARY KEY AUTO_INCREMENT,
    retsept_nimi varchar(100),
    kirjeldus varchar(200),
    juhend text,
    sisestatud_kp date,
    kasutaja_ID int,
    kategooria_ID int,
    FOREIGN KEY (kasutaja_ID) REFERENCES kasutaja(kasutaja_ID),
    FOREIGN KEY (kategooria_ID) REFERENCES kategooria(kategooria_ID));

CREATE TABLE tehtud(
    tehtud_ID int PRIMARY KEY AUTO_INCREMENT,
    tehtud_kp date,
    retsept_ID int,
    FOREIGN KEY (retsept_ID) REFERENCES retsept(retsept_ID));
