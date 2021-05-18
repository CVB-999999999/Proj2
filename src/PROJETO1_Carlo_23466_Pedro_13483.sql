/*****************************************************************************************************************
                                    PROJETO PARA A CADEIRA DE PROJETO I
                Tema: "Gestão de pedido e entregas de refeições ao domicilio de um restaurante"
                Autor: Carlos Vilas Boas - Pedro Ferreira
                Ano: 2020
                Nº: 23466 23483
                Turno: A
                
                Versão: V23
                Data: 16/01/2021
******************************************************************************************************************/

/*---------------------------------------------------
                    Elimina as Tabelas
-----------------------------------------------------*/
/*
DROP TABLE menu;
DROP TABLE cliente;
DROP TABLE funcionarios;
DROP TABLE fornecedores;
DROP TABLE encomendaFornecedores;
DROP TABLE estadoEncomendas;
DROP TABLE encomendas;
DROP TABLE detalheEncomenda;
DROP TABLE tipoEstados;
DROP TABLE menuMateriais;
DROP TABLE materiaPrima;
DROP TABLE detalheEncomendaFornecedor;
DROP TABLE diversosEstados;
*/
/*---------------------------------------------------
                    Cria as Tabelas
-----------------------------------------------------*/
/* Cria a TABELA MENU */
CREATE TABLE  menu  (
    menuRefPrato number NOT NULL, 
    menuNome  varchar2(50) NOT NULL,
    menuDescricao  varchar2(3000) NOT NULL,
    menuPrecoCusto  number NOT NULL,
    menuPrecoPVP  number NOT NULL,
    menuDataAtualizacao  date DEFAULT NULL,
    menuDataCriacao  date NOT NULL,
    menuNEncomendas number DEFAULT 0,
    emUso number DEFAULT NULL,  /* Determina se o menu está á venda */
    PRIMARY KEY ( menuRefPrato )
);

/* Cria a TABELA CLIENTE */
CREATE TABLE  cliente  (
    clienteNCliente number NOT NULL, 
    clienteNome  varchar2(50) NOT NULL,
    clienteEmail  varchar2(50) NOT NULL,
    clienteTelemovel  varchar2(50) NOT NULL,
    clienteEnderecoLinha1  varchar2(50) NOT NULL,
    clienteEnderecoLinha2  varchar2(50) DEFAULT NULL,
    clienteCidade  varchar2(50) NOT NULL,
    clienteCodigoPostal  varchar2(15) DEFAULT NULL,
    clientePass  varchar2(50) NOT NULL, 
    PRIMARY KEY ( clienteNCliente )
);

/* Cria a TABELA FUNCIONARIOS */
CREATE TABLE  funcionarios  (
    funcionariosCodFuncionario number NOT NULL, 
    funcionariosNome  varchar2(50) NOT NULL,
    funcionariosFuncao  varchar2(50) NOT NULL,
    funcionariosDataAdmissao  date NOT NULL,
    PRIMARY KEY ( funcionariosCodFuncionario )
);

/* Cria a TABELA FORNECEDORES */
CREATE TABLE  fornecedores  (
    fornecedoresCodFornecedor number NOT NULL, 
    fornecedoresNome  varchar2(50) NOT NULL,
    fornecedoresEmail  varchar2(50) NOT NULL,
    fornecedoresTelemovel  varchar2(50) NOT NULL,
    fornecedoresEnderecoLinha1  varchar2(50) NOT NULL,
    fornecedoresEnderecoLinha2  varchar2(50) DEFAULT NULL,
    fornecedoresCidade  varchar2(50) NOT NULL,
    fornecedoresCodigoPostal  varchar2(15) DEFAULT NULL,
    fornecedoresDescricao  varchar2(3000) NOT NULL,
    PRIMARY KEY ( fornecedoresCodFornecedor )
);


/* Cria a TABELA DIVERSOS ESTADOS */
CREATE TABLE  diversosEstados  (
    diversosEstadosIDEstado number NOT NULL, 
    diversosEstadosNome varchar2(50) NOT NULL, 
    diversosEstadosDescricao varchar2(1000),             
    PRIMARY KEY ( diversosEstadosIDEstado )
);

/* Cria a TABELA ENCOMENDA FORNECEDORES */
CREATE TABLE  encomendaFornecedores  (
    encomendaFornecedoresCodFatura number NOT NULL, 
    encomendaFornecedoresCodFornecedor number NOT NULL,
    encomendaFornecedoresCodFuncionario  number NOT NULL,
    encomendaFornecedoresData  date NOT NULL,
    encomendaFornecedoresCaminhoFaturaPC  varchar2(3000) NOT NULL,
    PRIMARY KEY ( encomendaFornecedoresCodFatura ),
    CONSTRAINT encomendaFornecedores_1  FOREIGN KEY ( encomendaFornecedoresCodFornecedor ) REFERENCES  fornecedores  ( fornecedoresCodFornecedor )
);

/* Cria a TABELA ENCOMENDAS */
CREATE TABLE  encomendas  (
    encomendasIDEncomenda number NOT NULL, 
    encomendasRefPrato  number NOT NULL,
    encomendasNCliente  number NOT NULL,
    encomendasDataHora  date NOT NULL,
    encomendasMetodoPagamento  varchar2(100) NOT NULL,
    encomendasConfirmarRecebido  varchar2(10) NOT NULL,
    PRIMARY KEY ( encomendasIDEncomenda ),
    CONSTRAINT encomendas_2 FOREIGN KEY ( encomendasNCliente ) REFERENCES cliente ( clienteNCliente )
);

/* Cria a TABELA DETALHE ENCOMENDA */
CREATE TABLE  detalheEncomenda  (
    detalheEncomendaRefPrato number NOT NULL, 
    detalheEncomendaIDEncomenda number NOT NULL, 
    detalheEncomendaPreco  number NOT NULL,
    detalheEncomendaQuantidade number NOT NULL, 
    PRIMARY KEY ( detalheEncomendaRefPrato,  detalheEncomendaIDEncomenda),
    CONSTRAINT detalheEncomenda_1  FOREIGN KEY ( detalheEncomendaRefPrato ) REFERENCES  menu  ( menuRefPrato ),
    CONSTRAINT detalheEncomenda_2  FOREIGN KEY ( detalheEncomendaIDEncomenda ) REFERENCES  encomendas  ( encomendasIDEncomenda )
);

/* Cria a TABELA TIPOS ESTADOS */
CREATE TABLE  tipoEstados  (
    tipoEstadosIDEstado number GENERATED ALWAYS as IDENTITY(START with 1 INCREMENT by 1), 
    tipoEstadosDataHora  date NOT NULL,
    tipoEstadosIDEncomenda number NOT NULL,
    tipoEstadosCodFuncionario number NOT NULL,
    tipoEstadosIDEstadoDiverso number NOT NULL,
    PRIMARY KEY ( tipoEstadosIDEstado),
    CONSTRAINT tipoEstados_1  FOREIGN KEY ( tipoEstadosIDEncomenda ) REFERENCES  encomendas  ( encomendasIDEncomenda ),
    CONSTRAINT tipoEstados_2  FOREIGN KEY ( tipoEstadosCodFuncionario ) REFERENCES  funcionarios  ( funcionariosCodFuncionario ),
    CONSTRAINT tipoEstados_3  FOREIGN KEY ( tipoEstadosIDEstadoDiverso ) REFERENCES  diversosEstados  ( diversosEstadosIDEstado )
);

/* Cria a TABELA MATERIA PRIMA */
CREATE TABLE  materiaPrima  (
    materiaPrimaRefProduto number NOT NULL, 
    materiaPrimaCodFuncionario number NOT NULL, 
    materiaPrimaNome  varchar2(50) NOT NULL,
    materiaPrimaQuantidadeAtual number NOT NULL,             
    materiaPrimaQuantidadeMinima number NOT NULL,
    materiaPrimaDataHoraVerificacao date DEFAULT NULL,
    PRIMARY KEY ( materiaPrimaRefProduto ),
    CONSTRAINT materiaPrima_2  FOREIGN KEY ( materiaPrimaCodFuncionario ) REFERENCES  funcionarios  ( funcionariosCodFuncionario )
);

/* Cria a TABELA MENU MATERIAIS */
CREATE TABLE  menuMateriais  (
    menuMateriaisRefPrato number NOT NULL, 
    menuMateriaisRefProduto number NOT NULL, 
    quantidade number DEFAULT 1,
    PRIMARY KEY ( menuMateriaisRefPrato, menuMateriaisRefProduto ),
    CONSTRAINT menuMateriais_1  FOREIGN KEY ( menuMateriaisRefPrato ) REFERENCES  menu  ( menuRefPrato ),
    CONSTRAINT menuMateriais_2  FOREIGN KEY ( menuMateriaisRefProduto ) REFERENCES  materiaPrima  ( materiaPrimaRefProduto )
);

/* Cria a TABELA DETALHE ENCOMENDA FORNECEDOR */
CREATE TABLE  detalheEncomendaFornecedor  (
    detalheEncomendaFornecedorID number NOT NULL, 
    detalheEncomendaFornecedorCodFatura number NOT NULL, 
    detalheEncomendaFornecedorRefProduto number NOT NULL, 
    detalheEncomendaFornecedorQuantidade number NOT NULL,              
    PRIMARY KEY ( detalheEncomendaFornecedorID ),
    CONSTRAINT detalheEncomendaFornecedor_1  FOREIGN KEY ( detalheEncomendaFornecedorCodFatura ) REFERENCES  encomendaFornecedores  ( encomendaFornecedoresCodFatura ),
    CONSTRAINT detalheEncomendaFornecedor_2  FOREIGN KEY ( detalheEncomendaFornecedorRefProduto ) REFERENCES  materiaPrima  ( materiaPrimaRefProduto )
);

/*---------------------------------------------------
                   Insere nas Tabelas
-----------------------------------------------------*/
/*************************************************
                INSERE NA TABELA MENU
*************************************************/
INSERT INTO menu (menuRefPrato,menuNome,menuDescricao,menuPrecoCusto,menuPrecoPVP,menuDataAtualizacao,menuDataCriacao,menuNEncomendas) VALUES (1,'Cozido a Protuguesa','Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum','57,73','3,25',to_date( '31/12/1969','dd/mm/yyyy' ),to_date( '27/12/2020','dd/mm/yyyy' ),0);
INSERT INTO menu (menuRefPrato,menuNome,menuDescricao,menuPrecoCusto,menuPrecoPVP,menuDataAtualizacao,menuDataCriacao,menuNEncomendas) VALUES (2,'Cuscos com vegetais','Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus. Nulla eget metus eu erat semper rutrum. Fusce dolor quam, elementum at, egestas a, scelerisque sed, sapien. Nunc pulvinar arcu et pede. Nunc sed orci lobortis augue scelerisque mollis. Phasellus libero mauris, aliquam eu, accumsan','87,75','3,06',to_date( '31/12/1969','dd/mm/yyyy' ),to_date( '02/03/2021','dd/mm/yyyy' ),15);
INSERT INTO menu (menuRefPrato,menuNome,menuDescricao,menuPrecoCusto,menuPrecoPVP,menuDataAtualizacao,menuDataCriacao,menuNEncomendas) VALUES (3,'Frango no churrasco','Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor.','96,64','4,93',to_date( '31/12/1969','dd/mm/yyyy' ),to_date( '29/12/2020','dd/mm/yyyy' ),2);
INSERT INTO menu (menuRefPrato,menuNome,menuDescricao,menuPrecoCusto,menuPrecoPVP,menuDataAtualizacao,menuDataCriacao,menuNEncomendas) VALUES (4,'Osteria di Porto','Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus. Nulla eget metus eu erat semper rutrum. Fusce dolor quam, elementum at, egestas a, scelerisque sed, sapien. Nunc pulvinar arcu et pede. Nunc sed orci lobortis augue scelerisque mollis. Phasellus libero mauris, aliquam eu, accumsan sed, facilisis','67,97','3,27',to_date( '31/12/1969','dd/mm/yyyy' ),to_date( '21/09/2020','dd/mm/yyyy' ),15);
INSERT INTO menu (menuRefPrato,menuNome,menuDescricao,menuPrecoCusto,menuPrecoPVP,menuDataAtualizacao,menuDataCriacao,menuNEncomendas) VALUES (5,'Hambúrguer clássico','Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum','45,83','2,08',to_date( '31/12/1969','dd/mm/yyyy' ),to_date( '01/06/2021','dd/mm/yyyy' ),8);
INSERT INTO menu (menuRefPrato,menuNome,menuDescricao,menuPrecoCusto,menuPrecoPVP,menuDataAtualizacao,menuDataCriacao,menuNEncomendas) VALUES (6,'Filetes de pescada com arroz de feijão','Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus. Nulla eget metus eu erat semper rutrum. Fusce dolor quam, elementum at, egestas a, scelerisque sed, sapien. Nunc pulvinar arcu et pede. Nunc','18,33','3,04',to_date( '31/12/1969','dd/mm/yyyy' ),to_date( '04/04/2021','dd/mm/yyyy' ),28);
INSERT INTO menu (menuRefPrato,menuNome,menuDescricao,menuPrecoCusto,menuPrecoPVP,menuDataAtualizacao,menuDataCriacao,menuNEncomendas) VALUES (7,'Rodovalho, pimento, espinafres e ovas','Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus.','54,00','3,88',to_date( '31/12/1969','dd/mm/yyyy' ),to_date( '06/04/2021','dd/mm/yyyy' ),19);
INSERT INTO menu (menuRefPrato,menuNome,menuDescricao,menuPrecoCusto,menuPrecoPVP,menuDataAtualizacao,menuDataCriacao,menuNEncomendas) VALUES (8,'Risoto de açafrão com ossobuco','Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus. Nulla eget metus eu erat semper rutrum. Fusce dolor quam, elementum at, egestas a, scelerisque sed, sapien. Nunc pulvinar arcu et pede. Nunc sed orci lobortis augue scelerisque mollis. Phasellus libero mauris, aliquam eu, accumsan sed, facilisis vitae, orci. Phasellus','69,23','1,72',to_date( '31/12/1969','dd/mm/yyyy' ),to_date( '09/05/2021','dd/mm/yyyy' ),1);
INSERT INTO menu (menuRefPrato,menuNome,menuDescricao,menuPrecoCusto,menuPrecoPVP,menuDataAtualizacao,menuDataCriacao,menuNEncomendas) VALUES (9,'Bacalhau como à Gomes de Sá','Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus. Nulla eget metus eu erat semper rutrum. Fusce dolor quam, elementum at, egestas a,','83,68','1,47',to_date( '31/12/1969','dd/mm/yyyy' ),to_date( '10/09/2020','dd/mm/yyyy' ),11);
INSERT INTO menu (menuRefPrato,menuNome,menuDescricao,menuPrecoCusto,menuPrecoPVP,menuDataAtualizacao,menuDataCriacao,menuNEncomendas) VALUES (10,'Pizza Muti','Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus. Nulla eget metus eu erat semper rutrum. Fusce dolor quam, elementum at, egestas a, scelerisque sed, sapien. Nunc pulvinar arcu et pede. Nunc sed orci lobortis augue scelerisque mollis. Phasellus libero mauris, aliquam eu, accumsan sed,','50,53','3,93',to_date( '31/12/1969','dd/mm/yyyy' ),to_date( '07/09/2020','dd/mm/yyyy' ),16);

/*************************************************
             INSERE NA TABELA CLIENTE
*************************************************/
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (1,'Salvador','amet.dapibus.id@lacus.com','16951122 9545','8249 Lacus. Avenue','798-4536 Senectus Av.','Sesto al Reghena','57428','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (2,'Shannon','arcu.iaculis@necmetusfacilisis.org','16680623 5815','716-9981 Odio. Avenue','4937 Dignissim Avenue','Nil-Saint-Vincent-Saint-Martin','17967','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (3,'Marsden','commodo@auctorquistristique.ca','16430228 2951','6096 Mauris Avenue','P.O. Box 914, 7447 Cras Rd.','Kerkrade','08002','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (4,'Raya','magna.Praesent.interdum@Quisqueornare.org','16490821 2691','751-3656 Suspendisse Road','P.O. Box 413, 7697 Dignissim Av.','Pike Creek','64649','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (5,'Conan','libero.at.auctor@consequatnecmollis.com','16350717 9053','8281 Ante. Avenue','P.O. Box 212, 4188 Non, Rd.','Guysborough','71662','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (6,'Amelia','vitae.aliquam@dictum.ca','16681205 1123','235-4074 Lectus Rd.','139-3203 Donec Av.','Chañaral','08095','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (7,'Cade','sem.ut.dolor@noncursus.org','16790508 7446','6724 Sociis St.','3148 Odio. Rd.','Lo Espejo','23327','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (8,'Catherine','lobortis.nisi.nibh@Nuncullamcorper.edu','16930921 7058','304-9619 Ornare, Rd.','657 Sollicitudin Rd.','Bierges','98838','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (9,'Faith','in.hendrerit@Maecenas.edu','16511109 0741','Ap #986-4854 Nulla Av.','2500 Lectus Ave','Brindisi','83729','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (10,'Howard','Aliquam.tincidunt.nunc@Duiselementumdui.com','16790916 3664','762-9441 Ante. Rd.','7637 Dui Rd.','Quispamsis','37420','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (11,'Lars','a.purus@vulputateduinec.net','16500302 0962','P.O. Box 411, 4914 Montes, Road','531-890 Ut Avenue','Kerkhove','02847','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (12,'Brady','malesuada@nuncsit.com','16791205 8604','Ap #540-3529 Cursus Rd.','471-759 Nulla Avenue','Billings','07192','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (13,'Macaulay','a.malesuada@magna.com','16120614 1879','651-6686 Cursus Street','751-4671 Malesuada Avenue','Olympia','37184','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (14,'Octavia','Proin.velit.Sed@arcuNuncmauris.net','16751025 3128','143 Mi Av.','264-2198 Fusce Road','Temuco','37931','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (15,'Armando','magna.tellus.faucibus@ametdiam.org','16870905 1620','P.O. Box 241, 1118 Risus. Ave','Ap #555-7752 Libero Road','Spermalie','00299','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (16,'Igor','dolor@lacinia.co.uk','16330913 1997','8872 Nunc Rd.','328-2063 Nulla. St.','San Juan del Río','73586','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (17,'Kerry','odio.Aliquam@Integer.net','16220507 2974','543-7039 Mauris Avenue','579-7773 Diam Rd.','Gavirate','92550','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (18,'Channing','luctus.ipsum.leo@vitae.org','16231125 9291','Ap #527-2729 Nec Rd.','Ap #237-9153 Pellentesque, Rd.','Dijon','80793','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (19,'Leilani','dignissim@mattis.com','16740426 9289','P.O. Box 214, 6657 Quis Road','6654 Non, Rd.','Middlesbrough','67398','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (20,'Montana','Nam.porttitor@metusAliquamerat.edu','16850809 0712','5338 Sagittis St.','706-9649 Sit Ave','Saint-Dizier','56743','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (21,'Sebastian','Aliquam.tincidunt.nunc@euaccumsansed.net','16100323 7482','P.O. Box 405, 8496 Ante Road','521-5587 Consectetuer Ave','Duitama','18938','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (22,'Phyllis','faucibus.ut.nulla@Aliquamornarelibero.com','16430505 8416','P.O. Box 373, 5626 In St.','734-3240 Et Ave','Valcourt','06120','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (23,'Justin','ac@cubiliaCurae.ca','16570521 9219','623-5713 Facilisi. Ave','Ap #285-3871 Aliquam Ave','A Coruña','39834','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (24,'Richard','Mauris.ut.quam@magnisdis.co.uk','16790309 6837','P.O. Box 508, 4221 Proin Street','3058 Mus. Street','Berlin','55468','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (25,'Fuller','sit@nasceturridiculus.net','16470820 0664','5207 Est. Ave','155-4314 Nostra, St.','Bo?lhe','36418','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (26,'Jessamine','Morbi.quis@egetlaoreet.net','16421101 5195','531-6503 Enim. St.','Ap #967-3988 Ut Ave','Grande Cache','93987','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (27,'Jenna','pede@turpisnecmauris.com','16020911 6714','P.O. Box 730, 4662 Malesuada Street','Ap #297-1131 Morbi Av.','Finspång','18237','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (28,'Laurel','ipsum@pedeetrisus.com','16180505 2931','P.O. Box 443, 3895 Duis St.','P.O. Box 759, 2883 At, Rd.','Sanzeno','33898','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (29,'Jordan','aliquet.metus.urna@quisdiamPellentesque.edu','16900518 2291','2083 Nunc Rd.','Ap #971-9447 Lectus Street','La Baie','58339','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (30,'McKenzie','Integer.eu.lacus@dictummi.edu','16950526 2916','9613 Eu Rd.','P.O. Box 806, 4744 Ac, Av.','Warminster','34264','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (31,'Jael','rutrum.non.hendrerit@diamnuncullamcorper.net','16630928 4476','P.O. Box 608, 6957 Ornare. Avenue','126-6891 Consectetuer Street','Drongen','27559','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (32,'Dennis','Nunc@Maurisvelturpis.ca','16131010 1348','Ap #499-1953 Nibh. Rd.','P.O. Box 885, 5038 Sed Rd.','Noduwez','99245','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (33,'Conan','et@dictumProin.edu','16510310 5531','8626 Pharetra Rd.','480-3317 Nunc Street','Alto Baudó','30960','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (34,'Martena','dolor.Fusce@etnetuset.edu','16661130 3147','P.O. Box 247, 6825 Lorem Road','Ap #608-9384 Dictum Rd.','Kanchrapara','24081','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (35,'Felicia','Etiam.vestibulum.massa@egetnisidictum.net','16610619 4381','Ap #780-5093 Praesent Avenue','6520 Dictum Street','Rae Bareli','72822','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (36,'Leslie','felis.orci@ornare.co.uk','16460511 2103','P.O. Box 908, 5893 Euismod Street','946-1997 Neque Rd.','Sarreguemines','80377','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (37,'Jessamine','enim.nisl@diamnuncullamcorper.ca','16591007 7485','3264 Nec, Rd.','Ap #449-2998 Elit. Road','Bucheon','43596','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (38,'Nola','vulputate@massaVestibulumaccumsan.edu','16330411 0301','P.O. Box 741, 2787 Malesuada Avenue','430-6270 Morbi Rd.','Workum','51327','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (39,'Charlotte','odio.semper@cursus.edu','16721004 0734','3346 Sem. Av.','656-8709 Purus St.','Fosses-la-Ville','96295','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (40,'Faith','semper.Nam.tempor@nullaDonecnon.edu','16790607 7768','Ap #178-4276 Cras Rd.','288-9487 Luctus Ave','Lauro de Freitas','60619','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (41,'Oren','vulputate@enimnislelementum.ca','16571117 8003','P.O. Box 172, 3240 Euismod Road','9300 Convallis Avenue','Friedberg','45077','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (42,'Timothy','lacus.pede@purusactellus.ca','16700420 5113','Ap #806-5179 Sed Road','P.O. Box 430, 6837 Nisl St.','Castello dell''Acqua','32306','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (43,'Isadora','mattis.ornare.lectus@fermentumfermentumarcu.ca','16580423 3384','9232 Cras Ave','Ap #100-7436 Dapibus Avenue','Golitsyno','96599','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (44,'Amethyst','eget@vitae.co.uk','16970212 3093','753-9317 Arcu. Ave','700-7815 Ligula. Av.','Koszalin','98189','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (45,'Erica','pharetra.felis.eget@Fusce.ca','16520607 8866','Ap #490-8389 Risus Street','674-903 Urna, St.','Wa?brzych','47984','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (46,'Beatrice','Donec.porttitor@consectetuer.org','16640915 0759','Ap #295-7261 Nibh Avenue','Ap #342-9900 Fermentum Street','São José dos Pinhais','75710','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (47,'Emmanuel','Pellentesque.ut@lacusMauris.org','16210330 8959','P.O. Box 240, 5072 Sed Ave','322-4121 Rutrum St.','Wetaskiwin','60335','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (48,'Willa','pede.ultrices@sodaleselit.edu','16180311 7900','P.O. Box 219, 7428 Risus. Rd.','7284 Rutrum Rd.','Travo','89918','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (49,'Dieter','lobortis.Class.aptent@congueInscelerisque.co.uk','16610312 3482','Ap #480-9197 Et St.','P.O. Box 304, 5682 Cum Street','Jasper','83007','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (50,'Virginia','Pellentesque@augueSed.com','16001212 6959','558-274 At St.','296-5826 Aliquet Avenue','Fiumara','86389','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (51,'Samuel','laoreet.libero.et@aliquetvelvulputate.co.uk','16260521 9175','P.O. Box 404, 2438 Ipsum Rd.','Ap #461-3423 Vivamus St.','Bahawalnagar','08854','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (52,'Byron','sed@nunc.org','16350105 0599','768-8228 Nonummy Road','P.O. Box 757, 7079 Eget Rd.','Regina','60194','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (53,'Evelyn','nunc.est.mollis@Aliquamrutrumlorem.co.uk','16100119 9296','Ap #232-8057 Scelerisque Street','187-2642 Neque St.','Hofheim am Taunus','11778','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (54,'Adara','Donec.felis.orci@ornarelectusjusto.ca','16620128 1273','157-5929 Pede. St.','Ap #458-3671 Nullam Ave','Los Álamos','28292','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (55,'Russell','a@pedenonummyut.co.uk','16060226 9557','Ap #361-9255 Id Rd.','265-8822 Sed Road','Kakisa','31019','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (56,'Kristen','Nunc.mauris@faucibusMorbivehicula.org','16721120 5179','960-327 Justo Rd.','Ap #310-1695 Ut, St.','Istres','89552','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (57,'Camden','ac.sem@ornare.edu','16131019 7213','1794 Vehicula St.','589-2165 Sollicitudin Street','Mobile','62521','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (58,'Anthony','adipiscing@turpisnec.net','16900302 1046','Ap #662-5510 Nisi. Rd.','4020 Pretium St.','Montes Claros','19544','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (59,'Aurora','diam.nunc@acfermentum.net','16601104 5934','349-1559 Arcu Avenue','1950 Malesuada Ave','Tomé','65021','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (60,'Pandora','luctus@ridiculusmusDonec.ca','16680814 6564','593-1020 Neque Rd.','616-1702 Justo Rd.','Icheon','42975','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (61,'Theodore','ullamcorper@PhasellusornareFusce.edu','16361020 5415','1566 Hendrerit St.','746-3570 Erat Rd.','Aschersleben','56733','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (62,'Amos','amet.faucibus@duiCras.net','16550603 2811','8140 Mauris Avenue','613-1015 A, Avenue','Malloa','08665','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (63,'Chandler','tempor@Proinnonmassa.org','16830823 2829','P.O. Box 321, 436 Porttitor Rd.','7559 Sem Street','Ararat','12715','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (64,'Daquan','aliquam.enim.nec@nuncidenim.com','16070409 4572','906-1451 Pharetra Av.','P.O. Box 676, 3250 Metus Ave','Sint-Pieters-Leeuw','75438','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (65,'Rafael','tempor.arcu@Sed.net','16810628 8940','Ap #663-4917 Nostra, Road','P.O. Box 542, 6702 Enim. St.','Houtvenne','90045','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (66,'Raja','morbi.tristique@Morbisit.edu','16270504 6791','1546 Tempor Street','2373 Maecenas Street','Natales','60470','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (67,'Michelle','eget.nisi.dictum@sem.co.uk','16571210 9536','6726 Parturient Road','3806 Rutrum, Street','Aurangabad','25255','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (68,'Preston','Cras.interdum@cursus.org','16070608 3318','P.O. Box 995, 570 Risus. Rd.','9666 Etiam Rd.','Alto Biobío','11361','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (69,'Amal','Cras.convallis@egetmollis.ca','16690913 1002','Ap #555-8308 Nunc St.','Ap #845-9024 Sagittis Street','Baili?vre','69815','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (70,'Sage','nec.cursus@lacusEtiam.org','16161117 4515','Ap #985-9832 Facilisi. Street','3712 Tincidunt, Rd.','Saint Louis','77715','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (71,'Farrah','arcu@Aenean.net','16541003 3616','Ap #508-7587 Eget Road','Ap #436-4549 Pharetra St.','Adana','47090','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (72,'Edward','urna.justo.faucibus@ultriciessem.org','16440817 3112','269-7725 Sed Street','Ap #710-5650 Ut Rd.','Le Petit-Quevilly','21169','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (73,'Emerald','dignissim.pharetra.Nam@erat.co.uk','16700926 9940','P.O. Box 235, 2203 Tempus Av.','132-9829 Enim Rd.','Matamata','48635','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (74,'Martin','sed.turpis@semutdolor.net','16120322 1377','195-8631 Dui, Road','663-7533 Malesuada Av.','Bad Vöslau','43374','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (75,'Jasper','sociis@fringilla.edu','16001225 1393','Ap #580-4212 Amet Av.','976-8630 Curabitur St.','Crehen','86741','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (76,'Zelda','varius.orci@ipsum.com','16871018 0194','P.O. Box 554, 7693 Dolor St.','3392 Conubia Road','North Saanich','42546','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (77,'Iola','libero@vulputate.ca','16230729 9590','8378 Accumsan Street','Ap #829-309 Consectetuer, St.','Kozhikode','46570','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (78,'Tiger','tellus.Phasellus.elit@mollis.co.uk','16810628 8155','111-7427 Metus. Road','P.O. Box 304, 2965 Nunc Rd.','Lincoln','05833','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (79,'Isaiah','Etiam.ligula.tortor@Donecporttitor.org','16990819 4385','Ap #259-1103 Sollicitudin Avenue','228-8400 Nisi Avenue','San Floriano del Collio','77684','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (80,'Barry','lorem.ipsum.sodales@cursusnonegestas.org','16551228 5460','Ap #589-8433 Pellentesque Road','Ap #300-3353 Mauris Rd.','Chesterfield','08119','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (81,'Ashton','Nam@massaMauris.ca','16500311 8485','Ap #512-7316 In Street','6344 Malesuada St.','Milwaukee','24338','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (82,'Avram','lectus.Nullam.suscipit@necimperdiet.net','16100624 6266','Ap #901-3646 Orci, St.','Ap #728-5450 Parturient Avenue','Worthing','57125','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (83,'Cruz','nec.ligula.consectetuer@facilisisegetipsum.net','16640524 7989','P.O. Box 120, 3069 Erat Rd.','P.O. Box 398, 6550 Ac Av.','Schepdaal','18363','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (84,'Magee','tellus.Phasellus@dignissimtemporarcu.co.uk','16000827 1082','Ap #607-5264 Purus. Road','Ap #205-6019 Dignissim St.','Motta Camastra','87110','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (85,'Brianna','nulla@purus.net','16320408 4598','5642 A Rd.','Ap #720-9873 Nec Av.','Koningshooikt','00867','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (86,'Declan','non.lacinia.at@tristique.ca','16681025 4745','P.O. Box 761, 590 Tellus Ave','2015 Enim St.','Bad Oldesloe','99665','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (87,'Ahmed','sociis.natoque@sollicitudin.com','16681026 1427','Ap #495-2266 Nulla Street','7998 Lacus. St.','Francavilla Fontana','11699','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (88,'Candace','arcu.ac@feugiat.org','16930625 7487','Ap #611-3883 Sociis Rd.','P.O. Box 616, 5933 Ac Av.','Ludlow','82342','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (89,'Courtney','et.malesuada.fames@placerataugue.com','16710305 3133','P.O. Box 179, 7547 Nunc St.','299-7160 Nunc. St.','King Township','68422','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (90,'Zelda','et.euismod@Maurismolestie.co.uk','16631022 2317','P.O. Box 874, 502 Amet Road','P.O. Box 782, 170 Odio. Ave','Weyburn','89220','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (91,'Reece','malesuada.fringilla@temporerat.org','16350702 5728','Ap #967-9248 Consectetuer Avenue','919-6627 Pede Rd.','Colonnella','19141','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (92,'Orli','eget@nisi.ca','16130728 9056','9823 Cum Rd.','679-1769 Purus Avenue','Querétaro','43721','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (93,'Todd','nonummy@blandit.com','16910712 8275','6365 Eu Rd.','747-8955 Duis Ave','Adelaide','29420','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (94,'Amaya','lorem@lectus.net','16200222 9769','P.O. Box 804, 2289 At St.','P.O. Box 920, 1946 Enim. Rd.','Carovilli','45374','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (95,'Tasha','tempus.eu@lorem.net','16240409 3060','9702 Non, Rd.','6885 Augue. Ave','Cagli','26881','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (96,'Ima','auctor@feugiatnon.net','16200901 2614','Ap #478-9396 Posuere Ave','1657 Torquent St.','Cerchio','94286','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (97,'Karyn','facilisi.Sed@ornare.edu','16660828 0795','5752 Ante Avenue','Ap #306-5668 Tellus, Road','Saint-Georges','19622','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (98,'Ian','Aliquam.gravida.mauris@blanditcongue.edu','16760411 0432','515-3322 Ut Avenue','P.O. Box 635, 4270 Lorem Street','Yuryuzan','46102','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (99,'Gil','laoreet.posuere.enim@imperdietdictummagna.com','16900216 1876','P.O. Box 875, 6798 Arcu. Rd.','937-2498 Sed Avenue','Campli','96117','PASSWORD');
INSERT INTO cliente (clienteNCliente,clienteNome,clienteEmail,clienteTelemovel,clienteEnderecoLinha1,clienteEnderecoLinha2,clienteCidade,clienteCodigoPostal,clientePass) VALUES (100,'Jerry','mauris.eu.elit@Mauris.co.uk','16230510 2168','941-2976 Adipiscing St.','4701 Curabitur St.','Roccasicura','62433','PASSWORD');

/*************************************************
          INSERE NA TABELA FUNCIONARIOS
*************************************************/
INSERT INTO funcionarios (funcionariosCodFuncionario,funcionariosNome,funcionariosFuncao,funcionariosDataAdmissao) VALUES (1,'Latifah','Gerente',to_date('11/07/2019','dd/mm/yyyy' ));
INSERT INTO funcionarios (funcionariosCodFuncionario,funcionariosNome,funcionariosFuncao,funcionariosDataAdmissao) VALUES (2,'Lunea','Cozinheira',to_date('27/07/2019','dd/mm/yyyy' ));
INSERT INTO funcionarios (funcionariosCodFuncionario,funcionariosNome,funcionariosFuncao,funcionariosDataAdmissao) VALUES (3,'Ashton','Recepcionista',to_date('18/07/2019','dd/mm/yyyy' ));
INSERT INTO funcionarios (funcionariosCodFuncionario,funcionariosNome,funcionariosFuncao,funcionariosDataAdmissao) VALUES (4,'Avye','Distribuidor',to_date('27/07/2019','dd/mm/yyyy' ));
INSERT INTO funcionarios (funcionariosCodFuncionario,funcionariosNome,funcionariosFuncao,funcionariosDataAdmissao) VALUES (5,'Jordan','Cozinheiro',to_date('26/07/2019','dd/mm/yyyy' ));
INSERT INTO funcionarios (funcionariosCodFuncionario,funcionariosNome,funcionariosFuncao,funcionariosDataAdmissao) VALUES (6,'Maia','Ajudante Cozinha',to_date('04/07/2019','dd/mm/yyyy' ));
INSERT INTO funcionarios (funcionariosCodFuncionario,funcionariosNome,funcionariosFuncao,funcionariosDataAdmissao) VALUES (7,'Camilla','Distribuidor',to_date('09/07/2019','dd/mm/yyyy' ));
INSERT INTO funcionarios (funcionariosCodFuncionario,funcionariosNome,funcionariosFuncao,funcionariosDataAdmissao) VALUES (8,'Maxwell','Distribuidor',to_date('30/07/2019','dd/mm/yyyy' ));
INSERT INTO funcionarios (funcionariosCodFuncionario,funcionariosNome,funcionariosFuncao,funcionariosDataAdmissao) VALUES (9,'Wylie','Empregado de Mesa',to_date('12/07/2019','dd/mm/yyyy' ));
INSERT INTO funcionarios (funcionariosCodFuncionario,funcionariosNome,funcionariosFuncao,funcionariosDataAdmissao) VALUES (10,'Amela','Empregado de Mesa',to_date('07/07/2019','dd/mm/yyyy' ));

/*************************************************
          INSERE NA TABELA FORNECEDORES
*************************************************/
INSERT INTO fornecedores (fornecedoresCodFornecedor,fornecedoresNome,fornecedoresEmail,fornecedoresTelemovel,fornecedoresEnderecoLinha1,fornecedoresEnderecoLinha2,fornecedoresCidade,fornecedoresCodigoPostal,fornecedoresDescricao) VALUES (1,'Et Netus Ltd','dapibus.ligula.Aliquam@aliquamenimnec.edu','99581261499','4533 Sed Ave','Ap #748-2381 Donec St.','Warwick','79574','Nulla facilisi. Sed neque. Sed eget lacus. Mauris non dui nec urna suscipit nonummy. Fusce fermentum fermentum');
INSERT INTO fornecedores (fornecedoresCodFornecedor,fornecedoresNome,fornecedoresEmail,fornecedoresTelemovel,fornecedoresEnderecoLinha1,fornecedoresEnderecoLinha2,fornecedoresCidade,fornecedoresCodigoPostal,fornecedoresDescricao) VALUES (2,'Pharetra Felis Eget Corp.','In.at@aptenttacitisociosqu.ca','81731252499','P.O. Box 432, 2744 Commodo Street','985-5956 Nullam Avenue','Lac Ste. Anne','36444','scelerisque neque sed sem egestas blandit. Nam nulla magna, malesuada vel, convallis in, cursus et, eros. Proin');
INSERT INTO fornecedores (fornecedoresCodFornecedor,fornecedoresNome,fornecedoresEmail,fornecedoresTelemovel,fornecedoresEnderecoLinha1,fornecedoresEnderecoLinha2,fornecedoresCidade,fornecedoresCodigoPostal,fornecedoresDescricao) VALUES (3,'Dui Nec Corporation','euismod.enim@fringillamilacinia.org','46412549799','3424 Dolor Rd.','1668 Montes, Avenue','Kahramanmara?','57124','amet, consectetuer adipiscing elit. Etiam laoreet, libero et tristique pellentesque, tellus sem mollis dui, in sodales elit erat');
INSERT INTO fornecedores (fornecedoresCodFornecedor,fornecedoresNome,fornecedoresEmail,fornecedoresTelemovel,fornecedoresEnderecoLinha1,fornecedoresEnderecoLinha2,fornecedoresCidade,fornecedoresCodigoPostal,fornecedoresDescricao) VALUES (4,'Vel Ltd','nibh.Donec@faucibusutnulla.org','89871934499','Ap #331-3291 Non Av.','P.O. Box 887, 6061 Nulla. Ave','Lacombe County','95828','Nunc ullamcorper, velit in aliquet lobortis, nisi nibh lacinia orci, consectetuer euismod est arcu ac orci. Ut semper pretium neque. Morbi quis urna.');
INSERT INTO fornecedores (fornecedoresCodFornecedor,fornecedoresNome,fornecedoresEmail,fornecedoresTelemovel,fornecedoresEnderecoLinha1,fornecedoresEnderecoLinha2,fornecedoresCidade,fornecedoresCodigoPostal,fornecedoresDescricao) VALUES (5,'Et Magnis Corporation','eu.odio@auctornuncnulla.com','26433579799','115-4611 Phasellus Ave','9036 Cursus Road','Jennersdorf','46375','Suspendisse commodo tincidunt nibh. Phasellus nulla. Integer vulputate, risus a');
INSERT INTO fornecedores (fornecedoresCodFornecedor,fornecedoresNome,fornecedoresEmail,fornecedoresTelemovel,fornecedoresEnderecoLinha1,fornecedoresEnderecoLinha2,fornecedoresCidade,fornecedoresCodigoPostal,fornecedoresDescricao) VALUES (6,'Sed Id Industries','nulla.magna@posuereenim.co.uk','99609536899','Ap #804-1687 Vestibulum Rd.','P.O. Box 651, 2289 Gravida Road','Gander','55818','arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis');
INSERT INTO fornecedores (fornecedoresCodFornecedor,fornecedoresNome,fornecedoresEmail,fornecedoresTelemovel,fornecedoresEnderecoLinha1,fornecedoresEnderecoLinha2,fornecedoresCidade,fornecedoresCodigoPostal,fornecedoresDescricao) VALUES (7,'Gravida Sit Amet Inc.','a.neque@orciUt.org','19229699699','P.O. Box 508, 6636 Rutrum Street','5643 Mauris Ave','Lloydminster','37060','ut, pharetra sed, hendrerit a, arcu. Sed et libero. Proin mi. Aliquam gravida mauris ut mi.');
INSERT INTO fornecedores (fornecedoresCodFornecedor,fornecedoresNome,fornecedoresEmail,fornecedoresTelemovel,fornecedoresEnderecoLinha1,fornecedoresEnderecoLinha2,fornecedoresCidade,fornecedoresCodigoPostal,fornecedoresDescricao) VALUES (9,'Non Cursus Non Associates','Donec.nibh.Quisque@Praesenteu.edu','22853830099','Ap #111-6635 Cras Rd.','811-7801 Libero St.','Gurgaon','69805','tempus mauris erat eget ipsum. Suspendisse sagittis. Nullam vitae diam. Proin dolor. Nulla semper');
INSERT INTO fornecedores (fornecedoresCodFornecedor,fornecedoresNome,fornecedoresEmail,fornecedoresTelemovel,fornecedoresEnderecoLinha1,fornecedoresEnderecoLinha2,fornecedoresCidade,fornecedoresCodigoPostal,fornecedoresDescricao) VALUES (10,'Facilisis Magna Industries','augue@Maecenas.org','14681460499','1777 Eu St.','811-3624 Sed Av.','Galashiels','67083','augue porttitor interdum. Sed auctor odio');
INSERT INTO fornecedores (fornecedoresCodFornecedor,fornecedoresNome,fornecedoresEmail,fornecedoresTelemovel,fornecedoresEnderecoLinha1,fornecedoresEnderecoLinha2,fornecedoresCidade,fornecedoresCodigoPostal,fornecedoresDescricao) VALUES (11,'Enim Ltd','eget@feugiatSednec.net','12737852599','839-690 Dui. Street','P.O. Box 656, 6480 Nascetur Ave','Farrukhabad-cum-Fatehgarh','59068','a purus. Duis elementum, dui quis accumsan convallis, ante lectus convallis est, vitae sodales nisi magna sed dui. Fusce aliquam, enim nec tempus scelerisque, lorem ipsum sodales');
INSERT INTO fornecedores (fornecedoresCodFornecedor,fornecedoresNome,fornecedoresEmail,fornecedoresTelemovel,fornecedoresEnderecoLinha1,fornecedoresEnderecoLinha2,fornecedoresCidade,fornecedoresCodigoPostal,fornecedoresDescricao) VALUES (12,'Urna Suscipit Incorporated','malesuada.augue.ut@atarcu.ca','96999582299','P.O. Box 752, 7921 Ante, Road','P.O. Box 284, 3743 Nulla St.','Orlando','85271','diam nunc, ullamcorper eu, euismod ac, fermentum vel, mauris. Integer sem elit, pharetra');
INSERT INTO fornecedores (fornecedoresCodFornecedor,fornecedoresNome,fornecedoresEmail,fornecedoresTelemovel,fornecedoresEnderecoLinha1,fornecedoresEnderecoLinha2,fornecedoresCidade,fornecedoresCodigoPostal,fornecedoresDescricao) VALUES (13,'Feugiat Metus PC','justo.nec@estcongue.edu','81520429299','Ap #252-251 Sagittis Avenue','412-7220 Magna. Av.','Maple Creek','14716','eu turpis. Nulla aliquet. Proin velit. Sed malesuada augue ut lacus. Nulla tincidunt, neque vitae semper egestas, urna justo faucibus lectus, a sollicitudin');
INSERT INTO fornecedores (fornecedoresCodFornecedor,fornecedoresNome,fornecedoresEmail,fornecedoresTelemovel,fornecedoresEnderecoLinha1,fornecedoresEnderecoLinha2,fornecedoresCidade,fornecedoresCodigoPostal,fornecedoresDescricao) VALUES (14,'Lectus Institute','magna@netus.com','62755543799','108-4810 Primis Road','P.O. Box 963, 6081 Ligula. St.','Montese','64665','mollis');
INSERT INTO fornecedores (fornecedoresCodFornecedor,fornecedoresNome,fornecedoresEmail,fornecedoresTelemovel,fornecedoresEnderecoLinha1,fornecedoresEnderecoLinha2,fornecedoresCidade,fornecedoresCodigoPostal,fornecedoresDescricao) VALUES (15,'Molestie Incorporated','at.lacus.Quisque@maurisblanditmattis.org','06609887699','P.O. Box 157, 5395 Maecenas Road','773-6235 Dictum Avenue','Marano Lagunare','87304','non arcu. Vivamus sit amet risus. Donec egestas.');
INSERT INTO fornecedores (fornecedoresCodFornecedor,fornecedoresNome,fornecedoresEmail,fornecedoresTelemovel,fornecedoresEnderecoLinha1,fornecedoresEnderecoLinha2,fornecedoresCidade,fornecedoresCodigoPostal,fornecedoresDescricao) VALUES (16,'Sed Neque Sed Limited','Aliquam.auctor.velit@pedeacurna.com','05550279999','Ap #309-862 Eros Rd.','Ap #175-6954 Mus. Road','Borås','97327','vitae diam. Proin dolor. Nulla semper tellus id nunc interdum feugiat. Sed nec metus facilisis lorem tristique aliquet. Phasellus fermentum');
INSERT INTO fornecedores (fornecedoresCodFornecedor,fornecedoresNome,fornecedoresEmail,fornecedoresTelemovel,fornecedoresEnderecoLinha1,fornecedoresEnderecoLinha2,fornecedoresCidade,fornecedoresCodigoPostal,fornecedoresDescricao) VALUES (17,'Dolor Dolor Tempus LLP','eu.eleifend@Phasellusfermentum.edu','81404710399','732-2704 Orci. St.','Ap #128-2025 Etiam St.','Iquique','92136','quis urna. Nunc quis arcu vel quam dignissim pharetra. Nam ac nulla. In tincidunt congue turpis. In condimentum. Donec at');
INSERT INTO fornecedores (fornecedoresCodFornecedor,fornecedoresNome,fornecedoresEmail,fornecedoresTelemovel,fornecedoresEnderecoLinha1,fornecedoresEnderecoLinha2,fornecedoresCidade,fornecedoresCodigoPostal,fornecedoresDescricao) VALUES (18,'Aenean Egestas Hendrerit Associates','Cum.sociis.natoque@Loremipsumdolor.co.uk','67717892999','576-2542 Convallis Road','Ap #436-939 Facilisis Av.','Barahanagar','73654','Vivamus euismod urna. Nullam lobortis quam a felis ullamcorper viverra. Maecenas iaculis aliquet diam. Sed diam');
INSERT INTO fornecedores (fornecedoresCodFornecedor,fornecedoresNome,fornecedoresEmail,fornecedoresTelemovel,fornecedoresEnderecoLinha1,fornecedoresEnderecoLinha2,fornecedoresCidade,fornecedoresCodigoPostal,fornecedoresDescricao) VALUES (19,'Dis Parturient LLP','Duis.gravida.Praesent@ametanteVivamus.com','71644005199','283-8260 Morbi Road','901-4288 Massa. St.','Tumba','83123','diam nunc, ullamcorper eu, euismod ac, fermentum vel, mauris. Integer sem elit, pharetra ut,');
INSERT INTO fornecedores (fornecedoresCodFornecedor,fornecedoresNome,fornecedoresEmail,fornecedoresTelemovel,fornecedoresEnderecoLinha1,fornecedoresEnderecoLinha2,fornecedoresCidade,fornecedoresCodigoPostal,fornecedoresDescricao) VALUES (20,'Consequat Purus Company','semper.pretium@eu.ca','33601708599','Ap #864-6348 Eu, St.','Ap #129-4142 Ac St.','Brugge Bruges','56555','ligula. Aenean');
INSERT INTO fornecedores (fornecedoresCodFornecedor,fornecedoresNome,fornecedoresEmail,fornecedoresTelemovel,fornecedoresEnderecoLinha1,fornecedoresEnderecoLinha2,fornecedoresCidade,fornecedoresCodigoPostal,fornecedoresDescricao) VALUES (21,'Orci Industries','Integer.in@lorem.net','91940946799','8835 In St.','944-6608 Ullamcorper St.','San Pablo','16027','at, egestas a, scelerisque sed, sapien.');
INSERT INTO fornecedores (fornecedoresCodFornecedor,fornecedoresNome,fornecedoresEmail,fornecedoresTelemovel,fornecedoresEnderecoLinha1,fornecedoresEnderecoLinha2,fornecedoresCidade,fornecedoresCodigoPostal,fornecedoresDescricao) VALUES (22,'Aliquam Incorporated','risus@rutrummagnaCras.com','43814580199','823-5965 Lacinia Rd.','130-5767 Nunc Rd.','Aurora','97027','Donec tempor, est ac mattis semper, dui lectus rutrum urna, nec luctus felis purus ac tellus. Suspendisse sed dolor. Fusce');
INSERT INTO fornecedores (fornecedoresCodFornecedor,fornecedoresNome,fornecedoresEmail,fornecedoresTelemovel,fornecedoresEnderecoLinha1,fornecedoresEnderecoLinha2,fornecedoresCidade,fornecedoresCodigoPostal,fornecedoresDescricao) VALUES (23,'Litora Foundation','Curabitur.consequat.lectus@sagittisaugueeu.org','95819046099','4392 Suspendisse Rd.','Ap #758-4656 Vestibulum Rd.','Quilpué','69971','ultrices. Vivamus rhoncus. Donec est. Nunc ullamcorper, velit in aliquet lobortis, nisi nibh');
INSERT INTO fornecedores (fornecedoresCodFornecedor,fornecedoresNome,fornecedoresEmail,fornecedoresTelemovel,fornecedoresEnderecoLinha1,fornecedoresEnderecoLinha2,fornecedoresCidade,fornecedoresCodigoPostal,fornecedoresDescricao) VALUES (24,'Dignissim Maecenas Ornare Corporation','tortor@mauris.net','85299085299','197-3591 Senectus Street','343 Quam, Street','Tanjung Pinang','26158','dolor dapibus gravida. Aliquam tincidunt, nunc ac mattis ornare, lectus ante dictum mi, ac mattis velit justo nec ante. Maecenas mi felis, adipiscing fringilla, porttitor');
INSERT INTO fornecedores (fornecedoresCodFornecedor,fornecedoresNome,fornecedoresEmail,fornecedoresTelemovel,fornecedoresEnderecoLinha1,fornecedoresEnderecoLinha2,fornecedoresCidade,fornecedoresCodigoPostal,fornecedoresDescricao) VALUES (25,'Adipiscing Elit Curabitur PC','cursus@tinciduntorci.co.uk','82300625599','P.O. Box 578, 8800 Duis Street','5180 Neque St.','Ellikom','33330','adipiscing. Mauris molestie pharetra nibh. Aliquam ornare, libero at auctor ullamcorper, nisl arcu iaculis enim, sit amet ornare lectus justo eu arcu. Morbi sit amet');
INSERT INTO fornecedores (fornecedoresCodFornecedor,fornecedoresNome,fornecedoresEmail,fornecedoresTelemovel,fornecedoresEnderecoLinha1,fornecedoresEnderecoLinha2,fornecedoresCidade,fornecedoresCodigoPostal,fornecedoresDescricao) VALUES (26,'Purus Inc.','neque@diamvelarcu.com','47593245999','P.O. Box 535, 1189 Sem, Rd.','536-6264 Nulla. Rd.','San Carlos','75567','turpis egestas. Fusce aliquet magna');
INSERT INTO fornecedores (fornecedoresCodFornecedor,fornecedoresNome,fornecedoresEmail,fornecedoresTelemovel,fornecedoresEnderecoLinha1,fornecedoresEnderecoLinha2,fornecedoresCidade,fornecedoresCodigoPostal,fornecedoresDescricao) VALUES (27,'Turpis PC','interdum.ligula@ut.edu','87241226299','P.O. Box 332, 2713 Phasellus St.','Ap #995-2758 Aliquam Ave','Hattian Bala','72551','mauris.');
INSERT INTO fornecedores (fornecedoresCodFornecedor,fornecedoresNome,fornecedoresEmail,fornecedoresTelemovel,fornecedoresEnderecoLinha1,fornecedoresEnderecoLinha2,fornecedoresCidade,fornecedoresCodigoPostal,fornecedoresDescricao) VALUES (28,'Tempus Risus Donec Associates','Curae.Donec@mattisCras.net','75286020599','3307 At, Road','909-6182 Lacus. Avenue','Walsall','78172','nec metus facilisis lorem tristique aliquet. Phasellus fermentum convallis ligula. Donec luctus aliquet odio. Etiam');
INSERT INTO fornecedores (fornecedoresCodFornecedor,fornecedoresNome,fornecedoresEmail,fornecedoresTelemovel,fornecedoresEnderecoLinha1,fornecedoresEnderecoLinha2,fornecedoresCidade,fornecedoresCodigoPostal,fornecedoresDescricao) VALUES (29,'Nec Metus Facilisis Incorporated','Phasellus.libero.mauris@pedemalesuada.edu','32907531099','P.O. Box 182, 2384 Non St.','5001 Aliquam Avenue','Torrejón de Ardoz','48704','diam at pretium aliquet, metus');
INSERT INTO fornecedores (fornecedoresCodFornecedor,fornecedoresNome,fornecedoresEmail,fornecedoresTelemovel,fornecedoresEnderecoLinha1,fornecedoresEnderecoLinha2,fornecedoresCidade,fornecedoresCodigoPostal,fornecedoresDescricao) VALUES (30,'Urna Nec Luctus Incorporated','sociis.natoque@Nuncut.net','19875133599','P.O. Box 620, 4551 Ante St.','241-3199 Ante Rd.','Huntsville','59510','non, lobortis quis, pede. Suspendisse dui. Fusce diam nunc, ullamcorper eu, euismod ac, fermentum vel, mauris. Integer sem elit, pharetra ut, pharetra sed, hendrerit');
INSERT INTO fornecedores (fornecedoresCodFornecedor,fornecedoresNome,fornecedoresEmail,fornecedoresTelemovel,fornecedoresEnderecoLinha1,fornecedoresEnderecoLinha2,fornecedoresCidade,fornecedoresCodigoPostal,fornecedoresDescricao) VALUES (31,'Eu Associates','dui.semper.et@urnaNullam.co.uk','49732016199','Ap #293-4327 Tempus Street','P.O. Box 637, 7440 Non, St.','Klimovsk','53083','nisi nibh lacinia orci, consectetuer euismod est arcu ac orci. Ut semper pretium neque. Morbi quis urna. Nunc quis arcu vel quam dignissim pharetra. Nam ac nulla. In tincidunt congue');
INSERT INTO fornecedores (fornecedoresCodFornecedor,fornecedoresNome,fornecedoresEmail,fornecedoresTelemovel,fornecedoresEnderecoLinha1,fornecedoresEnderecoLinha2,fornecedoresCidade,fornecedoresCodigoPostal,fornecedoresDescricao) VALUES (32,'Non Corp.','urna.Vivamus.molestie@commodoauctorvelit.co.uk','39904240299','575-8904 Proin Road','P.O. Box 771, 9269 Pede. Road','Strombeek-Bever','19216','erat vel pede blandit congue. In scelerisque scelerisque dui. Suspendisse ac metus vitae velit egestas lacinia. Sed');
INSERT INTO fornecedores (fornecedoresCodFornecedor,fornecedoresNome,fornecedoresEmail,fornecedoresTelemovel,fornecedoresEnderecoLinha1,fornecedoresEnderecoLinha2,fornecedoresCidade,fornecedoresCodigoPostal,fornecedoresDescricao) VALUES (33,'Mauris Quis Incorporated','gravida.sagittis@Namconsequatdolor.org','06441564199','P.O. Box 373, 6223 Sagittis Av.','449-3265 Et Av.','St. Paul','32548','vitae sodales nisi magna sed dui. Fusce aliquam, enim nec tempus scelerisque, lorem ipsum sodales purus, in molestie tortor nibh sit amet orci. Ut sagittis lobortis mauris.');
INSERT INTO fornecedores (fornecedoresCodFornecedor,fornecedoresNome,fornecedoresEmail,fornecedoresTelemovel,fornecedoresEnderecoLinha1,fornecedoresEnderecoLinha2,fornecedoresCidade,fornecedoresCodigoPostal,fornecedoresDescricao) VALUES (34,'Sit Amet Ornare Inc.','nec.eleifend.non@infaucibusorci.edu','42346472099','P.O. Box 910, 9251 Magna Av.','P.O. Box 570, 8259 Ac Avenue','Mobile','58886','dictum augue malesuada malesuada. Integer id');
INSERT INTO fornecedores (fornecedoresCodFornecedor,fornecedoresNome,fornecedoresEmail,fornecedoresTelemovel,fornecedoresEnderecoLinha1,fornecedoresEnderecoLinha2,fornecedoresCidade,fornecedoresCodigoPostal,fornecedoresDescricao) VALUES (35,'Sem Incorporated','Aenean.gravida@eteuismod.com','94879253599','570-9373 Nulla Road','P.O. Box 537, 5930 Vestibulum St.','College','64471','dictum. Proin eget odio. Aliquam vulputate ullamcorper magna. Sed eu eros. Nam consequat dolor vitae dolor. Donec fringilla. Donec feugiat metus');
INSERT INTO fornecedores (fornecedoresCodFornecedor,fornecedoresNome,fornecedoresEmail,fornecedoresTelemovel,fornecedoresEnderecoLinha1,fornecedoresEnderecoLinha2,fornecedoresCidade,fornecedoresCodigoPostal,fornecedoresDescricao) VALUES (36,'Dui Associates','ullamcorper.nisl.arcu@massalobortis.org','95303030099','Ap #837-1151 Laoreet, Rd.','P.O. Box 452, 8426 Donec Street','Saint-Remy','06768','Nulla aliquet. Proin velit. Sed malesuada augue ut lacus. Nulla tincidunt, neque vitae semper egestas, urna justo faucibus lectus, a sollicitudin orci sem eget massa.');
INSERT INTO fornecedores (fornecedoresCodFornecedor,fornecedoresNome,fornecedoresEmail,fornecedoresTelemovel,fornecedoresEnderecoLinha1,fornecedoresEnderecoLinha2,fornecedoresCidade,fornecedoresCodigoPostal,fornecedoresDescricao) VALUES (37,'Ante Blandit Foundation','augue.eu@telluseuaugue.com','69452677999','Ap #217-4193 Mauris St.','P.O. Box 929, 9731 Elit, St.','Salvirola','39980','Nullam feugiat placerat velit. Quisque varius. Nam porttitor scelerisque neque. Nullam nisl. Maecenas malesuada fringilla est. Mauris eu turpis. Nulla aliquet. Proin velit. Sed malesuada augue ut lacus. Nulla tincidunt,');
INSERT INTO fornecedores (fornecedoresCodFornecedor,fornecedoresNome,fornecedoresEmail,fornecedoresTelemovel,fornecedoresEnderecoLinha1,fornecedoresEnderecoLinha2,fornecedoresCidade,fornecedoresCodigoPostal,fornecedoresDescricao) VALUES (38,'Id Enim Curabitur Institute','lorem.tristique.aliquet@nisiCum.com','02674496999','P.O. Box 993, 455 Ante Av.','793-5951 Curabitur Rd.','Falmouth','94604','non, luctus sit amet, faucibus ut, nulla. Cras eu tellus eu augue porttitor');
INSERT INTO fornecedores (fornecedoresCodFornecedor,fornecedoresNome,fornecedoresEmail,fornecedoresTelemovel,fornecedoresEnderecoLinha1,fornecedoresEnderecoLinha2,fornecedoresCidade,fornecedoresCodigoPostal,fornecedoresDescricao) VALUES (39,'Convallis In Cursus Consulting','Quisque@nonluctussit.edu','92447534499','P.O. Box 146, 8775 Convallis Rd.','9391 Non, Av.','Armidale','86418','fringilla ornare placerat, orci lacus vestibulum lorem, sit amet ultricies sem magna nec');
INSERT INTO fornecedores (fornecedoresCodFornecedor,fornecedoresNome,fornecedoresEmail,fornecedoresTelemovel,fornecedoresEnderecoLinha1,fornecedoresEnderecoLinha2,fornecedoresCidade,fornecedoresCodigoPostal,fornecedoresDescricao) VALUES (40,'Mattis Ornare LLP','purus.Nullam.scelerisque@nunc.edu','65226412199','Ap #138-914 Nec Rd.','P.O. Box 295, 3380 Commodo Rd.','Bossi?re','82527','neque vitae semper egestas, urna');
INSERT INTO fornecedores (fornecedoresCodFornecedor,fornecedoresNome,fornecedoresEmail,fornecedoresTelemovel,fornecedoresEnderecoLinha1,fornecedoresEnderecoLinha2,fornecedoresCidade,fornecedoresCodigoPostal,fornecedoresDescricao) VALUES (41,'Quis PC','amet.nulla@scelerisquescelerisquedui.edu','51946871299','P.O. Box 288, 4894 Nec Rd.','P.O. Box 692, 5495 Mollis. St.','Matagami','89415','elit, pellentesque a, facilisis non, bibendum sed, est. Nunc laoreet lectus quis massa. Mauris vestibulum, neque sed dictum eleifend, nunc risus varius orci,');
INSERT INTO fornecedores (fornecedoresCodFornecedor,fornecedoresNome,fornecedoresEmail,fornecedoresTelemovel,fornecedoresEnderecoLinha1,fornecedoresEnderecoLinha2,fornecedoresCidade,fornecedoresCodigoPostal,fornecedoresDescricao) VALUES (42,'Dictum LLC','nisl.elementum.purus@disparturient.ca','13597568199','Ap #267-6704 Integer Road','P.O. Box 135, 9237 Rutrum Rd.','Birecik','04012','Nullam feugiat placerat velit. Quisque varius. Nam porttitor scelerisque neque. Nullam nisl. Maecenas malesuada fringilla est. Mauris eu turpis. Nulla aliquet.');
INSERT INTO fornecedores (fornecedoresCodFornecedor,fornecedoresNome,fornecedoresEmail,fornecedoresTelemovel,fornecedoresEnderecoLinha1,fornecedoresEnderecoLinha2,fornecedoresCidade,fornecedoresCodigoPostal,fornecedoresDescricao) VALUES (43,'Porttitor Eros Limited','cursus.luctus.ipsum@elitpellentesque.co.uk','53274676299','3770 Dui, Avenue','8687 Magna St.','Hawick','11517','montes, nascetur ridiculus mus. Aenean eget magna. Suspendisse tristique neque venenatis lacus. Etiam bibendum fermentum metus. Aenean sed pede nec ante blandit');
INSERT INTO fornecedores (fornecedoresCodFornecedor,fornecedoresNome,fornecedoresEmail,fornecedoresTelemovel,fornecedoresEnderecoLinha1,fornecedoresEnderecoLinha2,fornecedoresCidade,fornecedoresCodigoPostal,fornecedoresDescricao) VALUES (44,'Lorem Consulting','aliquam.adipiscing.lacus@Uttinciduntorci.com','07800988699','6791 Arcu. Rd.','Ap #933-1790 Quis Road','Rycroft','96424','Vivamus molestie dapibus ligula. Aliquam erat volutpat. Nulla dignissim. Maecenas ornare egestas ligula. Nullam feugiat placerat velit. Quisque varius. Nam');
INSERT INTO fornecedores (fornecedoresCodFornecedor,fornecedoresNome,fornecedoresEmail,fornecedoresTelemovel,fornecedoresEnderecoLinha1,fornecedoresEnderecoLinha2,fornecedoresCidade,fornecedoresCodigoPostal,fornecedoresDescricao) VALUES (45,'Duis Volutpat Foundation','Cras@Integereulacus.edu','89381836099','441 Lectus. Av.','Ap #827-6305 Dolor. Av.','Caplan','10629','mattis ornare, lectus ante');
INSERT INTO fornecedores (fornecedoresCodFornecedor,fornecedoresNome,fornecedoresEmail,fornecedoresTelemovel,fornecedoresEnderecoLinha1,fornecedoresEnderecoLinha2,fornecedoresCidade,fornecedoresCodigoPostal,fornecedoresDescricao) VALUES (46,'Luctus Ut PC','per@enim.net','51772796399','P.O. Box 303, 4707 Tempor Rd.','3263 Vitae, Street','Bicinicco','67610','Integer vitae nibh. Donec est mauris, rhoncus id, mollis nec, cursus a, enim. Suspendisse aliquet, sem ut cursus luctus, ipsum leo elementum sem, vitae aliquam eros turpis non');
INSERT INTO fornecedores (fornecedoresCodFornecedor,fornecedoresNome,fornecedoresEmail,fornecedoresTelemovel,fornecedoresEnderecoLinha1,fornecedoresEnderecoLinha2,fornecedoresCidade,fornecedoresCodigoPostal,fornecedoresDescricao) VALUES (47,'Ultrices Corporation','Ut.tincidunt.vehicula@sed.org','80974693499','P.O. Box 674, 8496 Lorem Av.','P.O. Box 457, 5001 Nec Rd.','Gunsan','63330','mi pede, nonummy ut,');
INSERT INTO fornecedores (fornecedoresCodFornecedor,fornecedoresNome,fornecedoresEmail,fornecedoresTelemovel,fornecedoresEnderecoLinha1,fornecedoresEnderecoLinha2,fornecedoresCidade,fornecedoresCodigoPostal,fornecedoresDescricao) VALUES (48,'A Purus Associates','velit.Quisque@lobortis.net','94304209999','797-5338 Eu Road','Ap #934-3533 Natoque St.','Labrecque','71358','condimentum. Donec at arcu. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae;');
INSERT INTO fornecedores (fornecedoresCodFornecedor,fornecedoresNome,fornecedoresEmail,fornecedoresTelemovel,fornecedoresEnderecoLinha1,fornecedoresEnderecoLinha2,fornecedoresCidade,fornecedoresCodigoPostal,fornecedoresDescricao) VALUES (49,'Proin Mi Aliquam LLP','Donec@imperdietullamcorperDuis.ca','62759142999','6466 Congue Rd.','Ap #858-3383 Risus. Av.','Los Angeles','62113','orci sem eget massa. Suspendisse eleifend. Cras sed leo. Cras vehicula aliquet libero.');
INSERT INTO fornecedores (fornecedoresCodFornecedor,fornecedoresNome,fornecedoresEmail,fornecedoresTelemovel,fornecedoresEnderecoLinha1,fornecedoresEnderecoLinha2,fornecedoresCidade,fornecedoresCodigoPostal,fornecedoresDescricao) VALUES (50,'Nullam Lobortis Quam Corporation','Quisque.imperdiet.erat@sitametmetus.ca','85333760199','5420 Accumsan St.','3854 Senectus Rd.','Thunder Bay','74017','scelerisque neque sed sem egestas blandit. Nam nulla magna, malesuada');

/*************************************************
    INSERE NA TABELA ENCOMENDAFORNECEDORES
*************************************************/
INSERT INTO encomendaFornecedores (encomendaFornecedoresCodFatura,encomendaFornecedoresCodFornecedor,encomendaFornecedoresCodFuncionario,encomendaFornecedoresData,encomendaFornecedoresCaminhoFaturaPC) VALUES (1,48,3,to_date('28/06/2019','dd/mm/yyyy' ),'faturas/nome_fatura.pdf');
INSERT INTO encomendaFornecedores (encomendaFornecedoresCodFatura,encomendaFornecedoresCodFornecedor,encomendaFornecedoresCodFuncionario,encomendaFornecedoresData,encomendaFornecedoresCaminhoFaturaPC) VALUES (2,10,9,to_date('19/06/2019','dd/mm/yyyy' ),'faturas/nome_fatura.pdf');
INSERT INTO encomendaFornecedores (encomendaFornecedoresCodFatura,encomendaFornecedoresCodFornecedor,encomendaFornecedoresCodFuncionario,encomendaFornecedoresData,encomendaFornecedoresCaminhoFaturaPC) VALUES (3,19,2,to_date('24/06/2019','dd/mm/yyyy' ),'faturas/nome_fatura.pdf');
INSERT INTO encomendaFornecedores (encomendaFornecedoresCodFatura,encomendaFornecedoresCodFornecedor,encomendaFornecedoresCodFuncionario,encomendaFornecedoresData,encomendaFornecedoresCaminhoFaturaPC) VALUES (4,42,6,to_date('21/06/2019','dd/mm/yyyy' ),'faturas/nome_fatura.pdf');
INSERT INTO encomendaFornecedores (encomendaFornecedoresCodFatura,encomendaFornecedoresCodFornecedor,encomendaFornecedoresCodFuncionario,encomendaFornecedoresData,encomendaFornecedoresCaminhoFaturaPC) VALUES (5,26,9,to_date('22/06/2019','dd/mm/yyyy' ),'faturas/nome_fatura.pdf');
INSERT INTO encomendaFornecedores (encomendaFornecedoresCodFatura,encomendaFornecedoresCodFornecedor,encomendaFornecedoresCodFuncionario,encomendaFornecedoresData,encomendaFornecedoresCaminhoFaturaPC) VALUES (6,35,6,to_date('09/06/2019','dd/mm/yyyy' ),'faturas/nome_fatura.pdf');
INSERT INTO encomendaFornecedores (encomendaFornecedoresCodFatura,encomendaFornecedoresCodFornecedor,encomendaFornecedoresCodFuncionario,encomendaFornecedoresData,encomendaFornecedoresCaminhoFaturaPC) VALUES (7,21,2,to_date('13/06/2019','dd/mm/yyyy' ),'faturas/nome_fatura.pdf');
INSERT INTO encomendaFornecedores (encomendaFornecedoresCodFatura,encomendaFornecedoresCodFornecedor,encomendaFornecedoresCodFuncionario,encomendaFornecedoresData,encomendaFornecedoresCaminhoFaturaPC) VALUES (8,26,4,to_date('05/06/2019','dd/mm/yyyy' ),'faturas/nome_fatura.pdf');
INSERT INTO encomendaFornecedores (encomendaFornecedoresCodFatura,encomendaFornecedoresCodFornecedor,encomendaFornecedoresCodFuncionario,encomendaFornecedoresData,encomendaFornecedoresCaminhoFaturaPC) VALUES (9,32,9,to_date('24/06/2019','dd/mm/yyyy' ),'faturas/nome_fatura.pdf');
INSERT INTO encomendaFornecedores (encomendaFornecedoresCodFatura,encomendaFornecedoresCodFornecedor,encomendaFornecedoresCodFuncionario,encomendaFornecedoresData,encomendaFornecedoresCaminhoFaturaPC) VALUES (10,21,6,to_date('03/06/2019','dd/mm/yyyy' ),'faturas/nome_fatura.pdf');
INSERT INTO encomendaFornecedores (encomendaFornecedoresCodFatura,encomendaFornecedoresCodFornecedor,encomendaFornecedoresCodFuncionario,encomendaFornecedoresData,encomendaFornecedoresCaminhoFaturaPC) VALUES (11,24,6,to_date('19/06/2019','dd/mm/yyyy' ),'faturas/nome_fatura.pdf');
INSERT INTO encomendaFornecedores (encomendaFornecedoresCodFatura,encomendaFornecedoresCodFornecedor,encomendaFornecedoresCodFuncionario,encomendaFornecedoresData,encomendaFornecedoresCaminhoFaturaPC) VALUES (12,5,4,to_date('23/06/2019','dd/mm/yyyy' ),'faturas/nome_fatura.pdf');
INSERT INTO encomendaFornecedores (encomendaFornecedoresCodFatura,encomendaFornecedoresCodFornecedor,encomendaFornecedoresCodFuncionario,encomendaFornecedoresData,encomendaFornecedoresCaminhoFaturaPC) VALUES (13,40,9,to_date('02/06/2019','dd/mm/yyyy' ),'faturas/nome_fatura.pdf');
INSERT INTO encomendaFornecedores (encomendaFornecedoresCodFatura,encomendaFornecedoresCodFornecedor,encomendaFornecedoresCodFuncionario,encomendaFornecedoresData,encomendaFornecedoresCaminhoFaturaPC) VALUES (14,2,8,to_date('04/06/2019','dd/mm/yyyy' ),'faturas/nome_fatura.pdf');
INSERT INTO encomendaFornecedores (encomendaFornecedoresCodFatura,encomendaFornecedoresCodFornecedor,encomendaFornecedoresCodFuncionario,encomendaFornecedoresData,encomendaFornecedoresCaminhoFaturaPC) VALUES (15,26,7,to_date('06/06/2019','dd/mm/yyyy' ),'faturas/nome_fatura.pdf');
INSERT INTO encomendaFornecedores (encomendaFornecedoresCodFatura,encomendaFornecedoresCodFornecedor,encomendaFornecedoresCodFuncionario,encomendaFornecedoresData,encomendaFornecedoresCaminhoFaturaPC) VALUES (16,23,10,to_date('01/06/2019','dd/mm/yyyy' ),'faturas/nome_fatura.pdf');
INSERT INTO encomendaFornecedores (encomendaFornecedoresCodFatura,encomendaFornecedoresCodFornecedor,encomendaFornecedoresCodFuncionario,encomendaFornecedoresData,encomendaFornecedoresCaminhoFaturaPC) VALUES (17,34,8,to_date('12/06/2019','dd/mm/yyyy' ),'faturas/nome_fatura.pdf');
INSERT INTO encomendaFornecedores (encomendaFornecedoresCodFatura,encomendaFornecedoresCodFornecedor,encomendaFornecedoresCodFuncionario,encomendaFornecedoresData,encomendaFornecedoresCaminhoFaturaPC) VALUES (18,27,7,to_date('20/06/2019','dd/mm/yyyy' ),'faturas/nome_fatura.pdf');
INSERT INTO encomendaFornecedores (encomendaFornecedoresCodFatura,encomendaFornecedoresCodFornecedor,encomendaFornecedoresCodFuncionario,encomendaFornecedoresData,encomendaFornecedoresCaminhoFaturaPC) VALUES (19,35,8,to_date('11/06/2019','dd/mm/yyyy' ),'faturas/nome_fatura.pdf');
INSERT INTO encomendaFornecedores (encomendaFornecedoresCodFatura,encomendaFornecedoresCodFornecedor,encomendaFornecedoresCodFuncionario,encomendaFornecedoresData,encomendaFornecedoresCaminhoFaturaPC) VALUES (20,34,2,to_date('03/06/2019','dd/mm/yyyy' ),'faturas/nome_fatura.pdf');
INSERT INTO encomendaFornecedores (encomendaFornecedoresCodFatura,encomendaFornecedoresCodFornecedor,encomendaFornecedoresCodFuncionario,encomendaFornecedoresData,encomendaFornecedoresCaminhoFaturaPC) VALUES (21,15,1,to_date('07/06/2019','dd/mm/yyyy' ),'faturas/nome_fatura.pdf');
INSERT INTO encomendaFornecedores (encomendaFornecedoresCodFatura,encomendaFornecedoresCodFornecedor,encomendaFornecedoresCodFuncionario,encomendaFornecedoresData,encomendaFornecedoresCaminhoFaturaPC) VALUES (22,7,9,to_date('25/06/2019','dd/mm/yyyy' ),'faturas/nome_fatura.pdf');
INSERT INTO encomendaFornecedores (encomendaFornecedoresCodFatura,encomendaFornecedoresCodFornecedor,encomendaFornecedoresCodFuncionario,encomendaFornecedoresData,encomendaFornecedoresCaminhoFaturaPC) VALUES (23,25,6,to_date('29/06/2019','dd/mm/yyyy' ),'faturas/nome_fatura.pdf');
INSERT INTO encomendaFornecedores (encomendaFornecedoresCodFatura,encomendaFornecedoresCodFornecedor,encomendaFornecedoresCodFuncionario,encomendaFornecedoresData,encomendaFornecedoresCaminhoFaturaPC) VALUES (24,19,5,to_date('28/06/2019','dd/mm/yyyy' ),'faturas/nome_fatura.pdf');
INSERT INTO encomendaFornecedores (encomendaFornecedoresCodFatura,encomendaFornecedoresCodFornecedor,encomendaFornecedoresCodFuncionario,encomendaFornecedoresData,encomendaFornecedoresCaminhoFaturaPC) VALUES (25,14,1,to_date('15/06/2019','dd/mm/yyyy' ),'faturas/nome_fatura.pdf');
INSERT INTO encomendaFornecedores (encomendaFornecedoresCodFatura,encomendaFornecedoresCodFornecedor,encomendaFornecedoresCodFuncionario,encomendaFornecedoresData,encomendaFornecedoresCaminhoFaturaPC) VALUES (26,42,7,to_date('22/06/2019','dd/mm/yyyy' ),'faturas/nome_fatura.pdf');
INSERT INTO encomendaFornecedores (encomendaFornecedoresCodFatura,encomendaFornecedoresCodFornecedor,encomendaFornecedoresCodFuncionario,encomendaFornecedoresData,encomendaFornecedoresCaminhoFaturaPC) VALUES (27,10,4,to_date('20/06/2019','dd/mm/yyyy' ),'faturas/nome_fatura.pdf');
INSERT INTO encomendaFornecedores (encomendaFornecedoresCodFatura,encomendaFornecedoresCodFornecedor,encomendaFornecedoresCodFuncionario,encomendaFornecedoresData,encomendaFornecedoresCaminhoFaturaPC) VALUES (28,47,3,to_date('13/06/2019','dd/mm/yyyy' ),'faturas/nome_fatura.pdf');
INSERT INTO encomendaFornecedores (encomendaFornecedoresCodFatura,encomendaFornecedoresCodFornecedor,encomendaFornecedoresCodFuncionario,encomendaFornecedoresData,encomendaFornecedoresCaminhoFaturaPC) VALUES (29,42,1,to_date('15/06/2019','dd/mm/yyyy' ),'faturas/nome_fatura.pdf');
INSERT INTO encomendaFornecedores (encomendaFornecedoresCodFatura,encomendaFornecedoresCodFornecedor,encomendaFornecedoresCodFuncionario,encomendaFornecedoresData,encomendaFornecedoresCaminhoFaturaPC) VALUES (30,25,6,to_date('29/06/2019','dd/mm/yyyy' ),'faturas/nome_fatura.pdf');
INSERT INTO encomendaFornecedores (encomendaFornecedoresCodFatura,encomendaFornecedoresCodFornecedor,encomendaFornecedoresCodFuncionario,encomendaFornecedoresData,encomendaFornecedoresCaminhoFaturaPC) VALUES (31,23,10,to_date('06/06/2019','dd/mm/yyyy' ),'faturas/nome_fatura.pdf');
INSERT INTO encomendaFornecedores (encomendaFornecedoresCodFatura,encomendaFornecedoresCodFornecedor,encomendaFornecedoresCodFuncionario,encomendaFornecedoresData,encomendaFornecedoresCaminhoFaturaPC) VALUES (32,14,9,to_date('16/06/2019','dd/mm/yyyy' ),'faturas/nome_fatura.pdf');
INSERT INTO encomendaFornecedores (encomendaFornecedoresCodFatura,encomendaFornecedoresCodFornecedor,encomendaFornecedoresCodFuncionario,encomendaFornecedoresData,encomendaFornecedoresCaminhoFaturaPC) VALUES (33,30,5,to_date('24/06/2019','dd/mm/yyyy' ),'faturas/nome_fatura.pdf');
INSERT INTO encomendaFornecedores (encomendaFornecedoresCodFatura,encomendaFornecedoresCodFornecedor,encomendaFornecedoresCodFuncionario,encomendaFornecedoresData,encomendaFornecedoresCaminhoFaturaPC) VALUES (34,29,7,to_date('16/06/2019','dd/mm/yyyy' ),'faturas/nome_fatura.pdf');
INSERT INTO encomendaFornecedores (encomendaFornecedoresCodFatura,encomendaFornecedoresCodFornecedor,encomendaFornecedoresCodFuncionario,encomendaFornecedoresData,encomendaFornecedoresCaminhoFaturaPC) VALUES (35,34,4,to_date('13/06/2019','dd/mm/yyyy' ),'faturas/nome_fatura.pdf');
INSERT INTO encomendaFornecedores (encomendaFornecedoresCodFatura,encomendaFornecedoresCodFornecedor,encomendaFornecedoresCodFuncionario,encomendaFornecedoresData,encomendaFornecedoresCaminhoFaturaPC) VALUES (36,29,5,to_date('19/06/2019','dd/mm/yyyy' ),'faturas/nome_fatura.pdf');
INSERT INTO encomendaFornecedores (encomendaFornecedoresCodFatura,encomendaFornecedoresCodFornecedor,encomendaFornecedoresCodFuncionario,encomendaFornecedoresData,encomendaFornecedoresCaminhoFaturaPC) VALUES (37,14,1,to_date('25/06/2019','dd/mm/yyyy' ),'faturas/nome_fatura.pdf');
INSERT INTO encomendaFornecedores (encomendaFornecedoresCodFatura,encomendaFornecedoresCodFornecedor,encomendaFornecedoresCodFuncionario,encomendaFornecedoresData,encomendaFornecedoresCaminhoFaturaPC) VALUES (38,32,8,to_date('08/06/2019','dd/mm/yyyy' ),'faturas/nome_fatura.pdf');
INSERT INTO encomendaFornecedores (encomendaFornecedoresCodFatura,encomendaFornecedoresCodFornecedor,encomendaFornecedoresCodFuncionario,encomendaFornecedoresData,encomendaFornecedoresCaminhoFaturaPC) VALUES (39,31,8,to_date('22/06/2019','dd/mm/yyyy' ),'faturas/nome_fatura.pdf');
INSERT INTO encomendaFornecedores (encomendaFornecedoresCodFatura,encomendaFornecedoresCodFornecedor,encomendaFornecedoresCodFuncionario,encomendaFornecedoresData,encomendaFornecedoresCaminhoFaturaPC) VALUES (40,11,10,to_date('24/06/2019','dd/mm/yyyy' ),'faturas/nome_fatura.pdf');
INSERT INTO encomendaFornecedores (encomendaFornecedoresCodFatura,encomendaFornecedoresCodFornecedor,encomendaFornecedoresCodFuncionario,encomendaFornecedoresData,encomendaFornecedoresCaminhoFaturaPC) VALUES (41,9,10,to_date('08/06/2019','dd/mm/yyyy' ),'faturas/nome_fatura.pdf');
INSERT INTO encomendaFornecedores (encomendaFornecedoresCodFatura,encomendaFornecedoresCodFornecedor,encomendaFornecedoresCodFuncionario,encomendaFornecedoresData,encomendaFornecedoresCaminhoFaturaPC) VALUES (42,40,9,to_date('03/06/2019','dd/mm/yyyy' ),'faturas/nome_fatura.pdf');
INSERT INTO encomendaFornecedores (encomendaFornecedoresCodFatura,encomendaFornecedoresCodFornecedor,encomendaFornecedoresCodFuncionario,encomendaFornecedoresData,encomendaFornecedoresCaminhoFaturaPC) VALUES (43,47,9,to_date('08/06/2019','dd/mm/yyyy' ),'faturas/nome_fatura.pdf');
INSERT INTO encomendaFornecedores (encomendaFornecedoresCodFatura,encomendaFornecedoresCodFornecedor,encomendaFornecedoresCodFuncionario,encomendaFornecedoresData,encomendaFornecedoresCaminhoFaturaPC) VALUES (44,32,9,to_date('30/06/2019','dd/mm/yyyy' ),'faturas/nome_fatura.pdf');
INSERT INTO encomendaFornecedores (encomendaFornecedoresCodFatura,encomendaFornecedoresCodFornecedor,encomendaFornecedoresCodFuncionario,encomendaFornecedoresData,encomendaFornecedoresCaminhoFaturaPC) VALUES (45,9,6,to_date('13/06/2019','dd/mm/yyyy' ),'faturas/nome_fatura.pdf');
INSERT INTO encomendaFornecedores (encomendaFornecedoresCodFatura,encomendaFornecedoresCodFornecedor,encomendaFornecedoresCodFuncionario,encomendaFornecedoresData,encomendaFornecedoresCaminhoFaturaPC) VALUES (46,28,10,to_date('16/06/2019','dd/mm/yyyy' ),'faturas/nome_fatura.pdf');
INSERT INTO encomendaFornecedores (encomendaFornecedoresCodFatura,encomendaFornecedoresCodFornecedor,encomendaFornecedoresCodFuncionario,encomendaFornecedoresData,encomendaFornecedoresCaminhoFaturaPC) VALUES (47,5,2,to_date('24/06/2019','dd/mm/yyyy' ),'faturas/nome_fatura.pdf');
INSERT INTO encomendaFornecedores (encomendaFornecedoresCodFatura,encomendaFornecedoresCodFornecedor,encomendaFornecedoresCodFuncionario,encomendaFornecedoresData,encomendaFornecedoresCaminhoFaturaPC) VALUES (48,5,1,to_date('03/06/2019','dd/mm/yyyy' ),'faturas/nome_fatura.pdf');
INSERT INTO encomendaFornecedores (encomendaFornecedoresCodFatura,encomendaFornecedoresCodFornecedor,encomendaFornecedoresCodFuncionario,encomendaFornecedoresData,encomendaFornecedoresCaminhoFaturaPC) VALUES (49,3,10,to_date('15/06/2019','dd/mm/yyyy' ),'faturas/nome_fatura.pdf');
INSERT INTO encomendaFornecedores (encomendaFornecedoresCodFatura,encomendaFornecedoresCodFornecedor,encomendaFornecedoresCodFuncionario,encomendaFornecedoresData,encomendaFornecedoresCaminhoFaturaPC) VALUES (50,10,10,to_date('03/06/2019','dd/mm/yyyy' ),'faturas/nome_fatura.pdf');

/*************************************************
    INSERE NA TABELA DETALHEENCOMENDA
*************************************************/
INSERT INTO detalheEncomenda (detalheEncomendaRefPrato,detalheEncomendaIDEncomenda,detalheEncomendaPreco,detalheEncomendaQuantidade) VALUES (8,15,'14,02',3);
INSERT INTO detalheEncomenda (detalheEncomendaRefPrato,detalheEncomendaIDEncomenda,detalheEncomendaPreco,detalheEncomendaQuantidade) VALUES (3,3,'14,30',2);
INSERT INTO detalheEncomenda (detalheEncomendaRefPrato,detalheEncomendaIDEncomenda,detalheEncomendaPreco,detalheEncomendaQuantidade) VALUES (1,8,'13,35',1);
INSERT INTO detalheEncomenda (detalheEncomendaRefPrato,detalheEncomendaIDEncomenda,detalheEncomendaPreco,detalheEncomendaQuantidade) VALUES (8,11,'16,11',1);
INSERT INTO detalheEncomenda (detalheEncomendaRefPrato,detalheEncomendaIDEncomenda,detalheEncomendaPreco,detalheEncomendaQuantidade) VALUES (8,1,'18,04',3);
INSERT INTO detalheEncomenda (detalheEncomendaRefPrato,detalheEncomendaIDEncomenda,detalheEncomendaPreco,detalheEncomendaQuantidade) VALUES (2,10,'19,40',1);
INSERT INTO detalheEncomenda (detalheEncomendaRefPrato,detalheEncomendaIDEncomenda,detalheEncomendaPreco,detalheEncomendaQuantidade) VALUES (4,7,'17,05',3);
INSERT INTO detalheEncomenda (detalheEncomendaRefPrato,detalheEncomendaIDEncomenda,detalheEncomendaPreco,detalheEncomendaQuantidade) VALUES (5,17,'19,32',1);
INSERT INTO detalheEncomenda (detalheEncomendaRefPrato,detalheEncomendaIDEncomenda,detalheEncomendaPreco,detalheEncomendaQuantidade) VALUES (9,12,'15,30',1);
INSERT INTO detalheEncomenda (detalheEncomendaRefPrato,detalheEncomendaIDEncomenda,detalheEncomendaPreco,detalheEncomendaQuantidade) VALUES (7,13,'11,29',2);
INSERT INTO detalheEncomenda (detalheEncomendaRefPrato,detalheEncomendaIDEncomenda,detalheEncomendaPreco,detalheEncomendaQuantidade) VALUES (4,4,'14,77',2);
INSERT INTO detalheEncomenda (detalheEncomendaRefPrato,detalheEncomendaIDEncomenda,detalheEncomendaPreco,detalheEncomendaQuantidade) VALUES (4,18,'10,95',3);
INSERT INTO detalheEncomenda (detalheEncomendaRefPrato,detalheEncomendaIDEncomenda,detalheEncomendaPreco,detalheEncomendaQuantidade) VALUES (5,17,'17,56',1);
INSERT INTO detalheEncomenda (detalheEncomendaRefPrato,detalheEncomendaIDEncomenda,detalheEncomendaPreco,detalheEncomendaQuantidade) VALUES (8,4,'16,30',3);
INSERT INTO detalheEncomenda (detalheEncomendaRefPrato,detalheEncomendaIDEncomenda,detalheEncomendaPreco,detalheEncomendaQuantidade) VALUES (9,18,'10,41',2);
INSERT INTO detalheEncomenda (detalheEncomendaRefPrato,detalheEncomendaIDEncomenda,detalheEncomendaPreco,detalheEncomendaQuantidade) VALUES (4,14,'15,66',1);
INSERT INTO detalheEncomenda (detalheEncomendaRefPrato,detalheEncomendaIDEncomenda,detalheEncomendaPreco,detalheEncomendaQuantidade) VALUES (6,17,'14,93',1);
INSERT INTO detalheEncomenda (detalheEncomendaRefPrato,detalheEncomendaIDEncomenda,detalheEncomendaPreco,detalheEncomendaQuantidade) VALUES (2,7,'11,78',3);
INSERT INTO detalheEncomenda (detalheEncomendaRefPrato,detalheEncomendaIDEncomenda,detalheEncomendaPreco,detalheEncomendaQuantidade) VALUES (7,6,'18,72',3);
INSERT INTO detalheEncomenda (detalheEncomendaRefPrato,detalheEncomendaIDEncomenda,detalheEncomendaPreco,detalheEncomendaQuantidade) VALUES (2,8,'13,31',3);

/*************************************************
    INSERE NA TABELA ENCOMENDAS
*************************************************/
INSERT INTO encomendas (encomendasIDEncomenda,encomendasRefPrato,encomendasNCliente,encomendasDataHora,encomendasMetodoPagamento,encomendasConfirmarRecebido) VALUES (1,9,41,to_date('08/02/2020','dd/mm/yyyy' ),'1','1');
INSERT INTO encomendas (encomendasIDEncomenda,encomendasRefPrato,encomendasNCliente,encomendasDataHora,encomendasMetodoPagamento,encomendasConfirmarRecebido) VALUES (2,2,39,to_date('06/12/2020','dd/mm/yyyy' ),'1','1');
INSERT INTO encomendas (encomendasIDEncomenda,encomendasRefPrato,encomendasNCliente,encomendasDataHora,encomendasMetodoPagamento,encomendasConfirmarRecebido) VALUES (3,3,16,to_date('25/08/2020','dd/mm/yyyy' ),'1','1');
INSERT INTO encomendas (encomendasIDEncomenda,encomendasRefPrato,encomendasNCliente,encomendasDataHora,encomendasMetodoPagamento,encomendasConfirmarRecebido) VALUES (4,2,3,to_date('23/07/2020','dd/mm/yyyy' ),'1','1');
INSERT INTO encomendas (encomendasIDEncomenda,encomendasRefPrato,encomendasNCliente,encomendasDataHora,encomendasMetodoPagamento,encomendasConfirmarRecebido) VALUES (5,2,64,to_date('17/06/2020','dd/mm/yyyy' ),'1','1');
INSERT INTO encomendas (encomendasIDEncomenda,encomendasRefPrato,encomendasNCliente,encomendasDataHora,encomendasMetodoPagamento,encomendasConfirmarRecebido) VALUES (6,4,11,to_date('01/01/2020','dd/mm/yyyy' ),'1','1');
INSERT INTO encomendas (encomendasIDEncomenda,encomendasRefPrato,encomendasNCliente,encomendasDataHora,encomendasMetodoPagamento,encomendasConfirmarRecebido) VALUES (7,1,3,to_date('11/12/2019','dd/mm/yyyy' ),'1','1');
INSERT INTO encomendas (encomendasIDEncomenda,encomendasRefPrato,encomendasNCliente,encomendasDataHora,encomendasMetodoPagamento,encomendasConfirmarRecebido) VALUES (8,10,85,to_date('10/09/2020','dd/mm/yyyy' ),'1','1');
INSERT INTO encomendas (encomendasIDEncomenda,encomendasRefPrato,encomendasNCliente,encomendasDataHora,encomendasMetodoPagamento,encomendasConfirmarRecebido) VALUES (9,6,26,to_date('11/12/2019','dd/mm/yyyy' ),'1','1');
INSERT INTO encomendas (encomendasIDEncomenda,encomendasRefPrato,encomendasNCliente,encomendasDataHora,encomendasMetodoPagamento,encomendasConfirmarRecebido) VALUES (10,4,59,to_date('11/01/2020','dd/mm/yyyy' ),'1','1');
INSERT INTO encomendas (encomendasIDEncomenda,encomendasRefPrato,encomendasNCliente,encomendasDataHora,encomendasMetodoPagamento,encomendasConfirmarRecebido) VALUES (11,3,61,to_date('10/12/2019','dd/mm/yyyy' ),'1','1');
INSERT INTO encomendas (encomendasIDEncomenda,encomendasRefPrato,encomendasNCliente,encomendasDataHora,encomendasMetodoPagamento,encomendasConfirmarRecebido) VALUES (12,7,85,to_date('10/08/2019','dd/mm/yyyy' ),'1','1');
INSERT INTO encomendas (encomendasIDEncomenda,encomendasRefPrato,encomendasNCliente,encomendasDataHora,encomendasMetodoPagamento,encomendasConfirmarRecebido) VALUES (13,9,2,to_date('10/01/2019','dd/mm/yyyy' ),'1','1');
INSERT INTO encomendas (encomendasIDEncomenda,encomendasRefPrato,encomendasNCliente,encomendasDataHora,encomendasMetodoPagamento,encomendasConfirmarRecebido) VALUES (14,1,20,to_date('12/01/2020','dd/mm/yyyy' ),'1','1');
INSERT INTO encomendas (encomendasIDEncomenda,encomendasRefPrato,encomendasNCliente,encomendasDataHora,encomendasMetodoPagamento,encomendasConfirmarRecebido) VALUES (15,8,16,to_date('09/02/2019','dd/mm/yyyy' ),'1','1');
INSERT INTO encomendas (encomendasIDEncomenda,encomendasRefPrato,encomendasNCliente,encomendasDataHora,encomendasMetodoPagamento,encomendasConfirmarRecebido) VALUES (16,2,18,to_date('03/11/2020','dd/mm/yyyy' ),'1','1');
INSERT INTO encomendas (encomendasIDEncomenda,encomendasRefPrato,encomendasNCliente,encomendasDataHora,encomendasMetodoPagamento,encomendasConfirmarRecebido) VALUES (17,10,43,to_date('03/09/2020','dd/mm/yyyy' ),'1','1');
INSERT INTO encomendas (encomendasIDEncomenda,encomendasRefPrato,encomendasNCliente,encomendasDataHora,encomendasMetodoPagamento,encomendasConfirmarRecebido) VALUES (18,6,10,to_date('25/12/2019','dd/mm/yyyy' ),'1','1');
INSERT INTO encomendas (encomendasIDEncomenda,encomendasRefPrato,encomendasNCliente,encomendasDataHora,encomendasMetodoPagamento,encomendasConfirmarRecebido) VALUES (19,9,53,to_date('18/12/2020','dd/mm/yyyy' ),'1','1');
INSERT INTO encomendas (encomendasIDEncomenda,encomendasRefPrato,encomendasNCliente,encomendasDataHora,encomendasMetodoPagamento,encomendasConfirmarRecebido) VALUES (20,7,74,to_date('08/05/2020','dd/mm/yyyy' ),'1','1');

/*************************************************
    INSERE NA TABELA TIPOSESTADOS
*************************************************/
INSERT INTO tipoEstados (tipoEstadosDataHora,tipoEstadosIDEncomenda,tipoEstadosIDEstadoDiverso,tipoEstadosCodFuncionario) VALUES (to_date( '06/07/2020','dd/mm/yyyy' ), 1,1,2);
INSERT INTO tipoEstados (tipoEstadosDataHora,tipoEstadosIDEncomenda,tipoEstadosIDEstadoDiverso,tipoEstadosCodFuncionario) VALUES (to_date( '12/09/2020','dd/mm/yyyy' ),1,3,5);
INSERT INTO tipoEstados (tipoEstadosDataHora,tipoEstadosIDEncomenda,tipoEstadosIDEstadoDiverso,tipoEstadosCodFuncionario) VALUES (to_date( '01/06/2020','dd/mm/yyyy' ),16,1,2);
INSERT INTO tipoEstados (tipoEstadosDataHora,tipoEstadosIDEncomenda,tipoEstadosIDEstadoDiverso,tipoEstadosCodFuncionario) VALUES (to_date( '02/11/2020','dd/mm/yyyy' ),13,3,10);
INSERT INTO tipoEstados (tipoEstadosDataHora,tipoEstadosIDEncomenda,tipoEstadosIDEstadoDiverso,tipoEstadosCodFuncionario) VALUES (to_date( '22/07/2020','dd/mm/yyyy' ),18,3,6);
INSERT INTO tipoEstados (tipoEstadosDataHora,tipoEstadosIDEncomenda,tipoEstadosIDEstadoDiverso,tipoEstadosCodFuncionario) VALUES (to_date( '20/10/2020','dd/mm/yyyy' ),14,3,4);
INSERT INTO tipoEstados (tipoEstadosDataHora,tipoEstadosIDEncomenda,tipoEstadosIDEstadoDiverso,tipoEstadosCodFuncionario) VALUES (to_date( '18/11/2020','dd/mm/yyyy' ),6,3,5);
INSERT INTO tipoEstados (tipoEstadosDataHora,tipoEstadosIDEncomenda,tipoEstadosIDEstadoDiverso,tipoEstadosCodFuncionario) VALUES (to_date( '21/08/2020','dd/mm/yyyy' ),2,3,5);
INSERT INTO tipoEstados (tipoEstadosDataHora,tipoEstadosIDEncomenda,tipoEstadosIDEstadoDiverso,tipoEstadosCodFuncionario) VALUES (to_date( '08/12/2020','dd/mm/yyyy' ),14,5,6);
INSERT INTO tipoEstados (tipoEstadosDataHora,tipoEstadosIDEncomenda,tipoEstadosIDEstadoDiverso,tipoEstadosCodFuncionario) VALUES (to_date( '01/09/2020','dd/mm/yyyy' ),7,5,3);
INSERT INTO tipoEstados (tipoEstadosDataHora,tipoEstadosIDEncomenda,tipoEstadosIDEstadoDiverso,tipoEstadosCodFuncionario) VALUES (to_date( '30/10/2020','dd/mm/yyyy' ),17,1,3);
INSERT INTO tipoEstados (tipoEstadosDataHora,tipoEstadosIDEncomenda,tipoEstadosIDEstadoDiverso,tipoEstadosCodFuncionario) VALUES (to_date( '02/08/2020','dd/mm/yyyy' ),15,1,9);
INSERT INTO tipoEstados (tipoEstadosDataHora,tipoEstadosIDEncomenda,tipoEstadosIDEstadoDiverso,tipoEstadosCodFuncionario) VALUES (to_date( '31/10/2020','dd/mm/yyyy' ),6,5,2);
INSERT INTO tipoEstados (tipoEstadosDataHora,tipoEstadosIDEncomenda,tipoEstadosIDEstadoDiverso,tipoEstadosCodFuncionario) VALUES (to_date( '03/12/2020','dd/mm/yyyy' ),5,5,4);
INSERT INTO tipoEstados (tipoEstadosDataHora,tipoEstadosIDEncomenda,tipoEstadosIDEstadoDiverso,tipoEstadosCodFuncionario) VALUES (to_date( '16/11/2020','dd/mm/yyyy' ),1,5,7);
INSERT INTO tipoEstados (tipoEstadosDataHora,tipoEstadosIDEncomenda,tipoEstadosIDEstadoDiverso,tipoEstadosCodFuncionario) VALUES (to_date( '22/09/2020','dd/mm/yyyy' ),9,1,4);
INSERT INTO tipoEstados (tipoEstadosDataHora,tipoEstadosIDEncomenda,tipoEstadosIDEstadoDiverso,tipoEstadosCodFuncionario) VALUES (to_date( '18/10/2020','dd/mm/yyyy' ),20,5,5);
INSERT INTO tipoEstados (tipoEstadosDataHora,tipoEstadosIDEncomenda,tipoEstadosIDEstadoDiverso,tipoEstadosCodFuncionario) VALUES (to_date( '09/10/2020','dd/mm/yyyy' ),12,5,7);
INSERT INTO tipoEstados (tipoEstadosDataHora,tipoEstadosIDEncomenda,tipoEstadosIDEstadoDiverso,tipoEstadosCodFuncionario) VALUES (to_date( '09/06/2020','dd/mm/yyyy' ),6,1,9);
INSERT INTO tipoEstados (tipoEstadosDataHora,tipoEstadosIDEncomenda,tipoEstadosIDEstadoDiverso,tipoEstadosCodFuncionario) VALUES (to_date( '12/07/2020','dd/mm/yyyy' ),18,5,3);
INSERT INTO tipoEstados (tipoEstadosDataHora,tipoEstadosIDEncomenda,tipoEstadosIDEstadoDiverso,tipoEstadosCodFuncionario) VALUES (to_date( '22/09/2020','dd/mm/yyyy' ),6,5,2);
INSERT INTO tipoEstados (tipoEstadosDataHora,tipoEstadosIDEncomenda,tipoEstadosIDEstadoDiverso,tipoEstadosCodFuncionario) VALUES (to_date( '25/06/2020','dd/mm/yyyy' ),14,3,6);
INSERT INTO tipoEstados (tipoEstadosDataHora,tipoEstadosIDEncomenda,tipoEstadosIDEstadoDiverso,tipoEstadosCodFuncionario) VALUES (to_date( '22/09/2020','dd/mm/yyyy' ),17,5,3);
INSERT INTO tipoEstados (tipoEstadosDataHora,tipoEstadosIDEncomenda,tipoEstadosIDEstadoDiverso,tipoEstadosCodFuncionario) VALUES (to_date( '04/10/2020','dd/mm/yyyy' ),19,3,4);
INSERT INTO tipoEstados (tipoEstadosDataHora,tipoEstadosIDEncomenda,tipoEstadosIDEstadoDiverso,tipoEstadosCodFuncionario) VALUES (to_date( '20/08/2020','dd/mm/yyyy' ),20,5,5);
INSERT INTO tipoEstados (tipoEstadosDataHora,tipoEstadosIDEncomenda,tipoEstadosIDEstadoDiverso,tipoEstadosCodFuncionario) VALUES (to_date( '09/10/2020','dd/mm/yyyy' ),14,3,3);
INSERT INTO tipoEstados (tipoEstadosDataHora,tipoEstadosIDEncomenda,tipoEstadosIDEstadoDiverso,tipoEstadosCodFuncionario) VALUES (to_date( '30/07/2020','dd/mm/yyyy' ),10,3,2);
INSERT INTO tipoEstados (tipoEstadosDataHora,tipoEstadosIDEncomenda,tipoEstadosIDEstadoDiverso,tipoEstadosCodFuncionario) VALUES (to_date( '18/11/2020','dd/mm/yyyy' ),8,1,7);
INSERT INTO tipoEstados (tipoEstadosDataHora,tipoEstadosIDEncomenda,tipoEstadosIDEstadoDiverso,tipoEstadosCodFuncionario) VALUES (to_date( '01/10/2020','dd/mm/yyyy' ),19,3,6);
INSERT INTO tipoEstados (tipoEstadosDataHora,tipoEstadosIDEncomenda,tipoEstadosIDEstadoDiverso,tipoEstadosCodFuncionario) VALUES (to_date( '16/11/2020','dd/mm/yyyy' ),2,1,4);

/*************************************************
    INSERE NA TABELA MATERIAPRIMA
*************************************************/
INSERT INTO materiaPrima (materiaPrimaRefProduto,materiaPrimaCodFuncionario,materiaPrimaNome,materiaPrimaQuantidadeAtual,materiaPrimaQuantidadeMinima,materiaPrimaDataHoraVerificacao ) VALUES (1,6, 'Cebolas', 30, 10, to_date( '20/12/2020','dd/mm/yyyy' ));
INSERT INTO materiaPrima (materiaPrimaRefProduto,materiaPrimaCodFuncionario,materiaPrimaNome,materiaPrimaQuantidadeAtual,materiaPrimaQuantidadeMinima,materiaPrimaDataHoraVerificacao ) VALUES (2,6, 'Batatas', 50, 26, to_date( '20/12/2020','dd/mm/yyyy' ));
INSERT INTO materiaPrima (materiaPrimaRefProduto,materiaPrimaCodFuncionario,materiaPrimaNome,materiaPrimaQuantidadeAtual,materiaPrimaQuantidadeMinima,materiaPrimaDataHoraVerificacao ) VALUES (3,6, 'Arroz', 10, 3, to_date( '20/12/2020','dd/mm/yyyy' ));
INSERT INTO materiaPrima (materiaPrimaRefProduto,materiaPrimaCodFuncionario,materiaPrimaNome,materiaPrimaQuantidadeAtual,materiaPrimaQuantidadeMinima,materiaPrimaDataHoraVerificacao ) VALUES (4,6, 'Pimenta', 4, 1, to_date( '20/12/2020','dd/mm/yyyy' ));
INSERT INTO materiaPrima (materiaPrimaRefProduto,materiaPrimaCodFuncionario,materiaPrimaNome,materiaPrimaQuantidadeAtual,materiaPrimaQuantidadeMinima,materiaPrimaDataHoraVerificacao ) VALUES (5,6, 'Sal', 15, 3, to_date( '20/12/2020','dd/mm/yyyy' ));
INSERT INTO materiaPrima (materiaPrimaRefProduto,materiaPrimaCodFuncionario,materiaPrimaNome,materiaPrimaQuantidadeAtual,materiaPrimaQuantidadeMinima,materiaPrimaDataHoraVerificacao ) VALUES (6,6, 'Alho', 8, 2, to_date( '20/12/2020','dd/mm/yyyy' ));
INSERT INTO materiaPrima (materiaPrimaRefProduto,materiaPrimaCodFuncionario,materiaPrimaNome,materiaPrimaQuantidadeAtual,materiaPrimaQuantidadeMinima,materiaPrimaDataHoraVerificacao ) VALUES (7,6, 'Azeite', 40, 6, to_date( '20/12/2020','dd/mm/yyyy' ));
INSERT INTO materiaPrima (materiaPrimaRefProduto,materiaPrimaCodFuncionario,materiaPrimaNome,materiaPrimaQuantidadeAtual,materiaPrimaQuantidadeMinima,materiaPrimaDataHoraVerificacao ) VALUES (8,6, 'Massa', 68, 15, to_date( '20/12/2020','dd/mm/yyyy' ));
INSERT INTO materiaPrima (materiaPrimaRefProduto,materiaPrimaCodFuncionario,materiaPrimaNome,materiaPrimaQuantidadeAtual,materiaPrimaQuantidadeMinima,materiaPrimaDataHoraVerificacao ) VALUES (9,6, 'Vinho Branco', 36, 15, to_date( '20/12/2020','dd/mm/yyyy' ));
INSERT INTO materiaPrima (materiaPrimaRefProduto,materiaPrimaCodFuncionario,materiaPrimaNome,materiaPrimaQuantidadeAtual,materiaPrimaQuantidadeMinima,materiaPrimaDataHoraVerificacao ) VALUES (10,6, 'Vinho Tinto', 40, 15, to_date( '20/12/2020','dd/mm/yyyy' ));
INSERT INTO materiaPrima (materiaPrimaRefProduto,materiaPrimaCodFuncionario,materiaPrimaNome,materiaPrimaQuantidadeAtual,materiaPrimaQuantidadeMinima,materiaPrimaDataHoraVerificacao ) VALUES (11,6, 'Bacalhau', 60, 20, to_date( '20/12/2020','dd/mm/yyyy' ));

/*************************************************
    INSERE NA TABELA MENUMATERIAIS
*************************************************/
INSERT INTO menuMateriais (menuMateriaisRefPrato,menuMateriaisRefProduto ) VALUES (5,6 );
INSERT INTO menuMateriais (menuMateriaisRefPrato,menuMateriaisRefProduto ) VALUES (4,8 );
INSERT INTO menuMateriais (menuMateriaisRefPrato,menuMateriaisRefProduto ) VALUES (10,11 );
INSERT INTO menuMateriais (menuMateriaisRefPrato,menuMateriaisRefProduto ) VALUES (8,8 );
INSERT INTO menuMateriais (menuMateriaisRefPrato,menuMateriaisRefProduto ) VALUES (5,4 );
INSERT INTO menuMateriais (menuMateriaisRefPrato,menuMateriaisRefProduto ) VALUES (1,3 );
INSERT INTO menuMateriais (menuMateriaisRefPrato,menuMateriaisRefProduto ) VALUES (6,7 );
INSERT INTO menuMateriais (menuMateriaisRefPrato,menuMateriaisRefProduto ) VALUES (4,5 );
INSERT INTO menuMateriais (menuMateriaisRefPrato,menuMateriaisRefProduto ) VALUES (8,3 );
INSERT INTO menuMateriais (menuMateriaisRefPrato,menuMateriaisRefProduto ) VALUES (4,2 );
INSERT INTO menuMateriais (menuMateriaisRefPrato,menuMateriaisRefProduto ) VALUES (3,1 );
INSERT INTO menuMateriais (menuMateriaisRefPrato,menuMateriaisRefProduto ) VALUES (2,7 );
INSERT INTO menuMateriais (menuMateriaisRefPrato,menuMateriaisRefProduto ) VALUES (1,8 );
INSERT INTO menuMateriais (menuMateriaisRefPrato,menuMateriaisRefProduto ) VALUES (9,9 );
INSERT INTO menuMateriais (menuMateriaisRefPrato,menuMateriaisRefProduto ) VALUES (10,7 );
INSERT INTO menuMateriais (menuMateriaisRefPrato,menuMateriaisRefProduto ) VALUES (5,5);
INSERT INTO menuMateriais (menuMateriaisRefPrato,menuMateriaisRefProduto ) VALUES (7,4 );
INSERT INTO menuMateriais (menuMateriaisRefPrato,menuMateriaisRefProduto ) VALUES (8,2 );
INSERT INTO menuMateriais (menuMateriaisRefPrato,menuMateriaisRefProduto ) VALUES (4,1 );

/*************************************************
    INSERE NA TABELA DETALHEENCOMENDAFORNCEDOR
*************************************************/
INSERT INTO detalheEncomendaFornecedor (detalheEncomendaFornecedorID,detalheEncomendaFornecedorCodFatura,detalheEncomendaFornecedorRefProduto,detalheEncomendaFornecedorQuantidade) VALUES (8,14,3,10);
INSERT INTO detalheEncomendaFornecedor (detalheEncomendaFornecedorID,detalheEncomendaFornecedorCodFatura,detalheEncomendaFornecedorRefProduto,detalheEncomendaFornecedorQuantidade) VALUES (49,44,4,17);
INSERT INTO detalheEncomendaFornecedor (detalheEncomendaFornecedorID,detalheEncomendaFornecedorCodFatura,detalheEncomendaFornecedorRefProduto,detalheEncomendaFornecedorQuantidade) VALUES (37,2,11,17);
INSERT INTO detalheEncomendaFornecedor (detalheEncomendaFornecedorID,detalheEncomendaFornecedorCodFatura,detalheEncomendaFornecedorRefProduto,detalheEncomendaFornecedorQuantidade) VALUES (45,24,7,20);
INSERT INTO detalheEncomendaFornecedor (detalheEncomendaFornecedorID,detalheEncomendaFornecedorCodFatura,detalheEncomendaFornecedorRefProduto,detalheEncomendaFornecedorQuantidade) VALUES (45,47,7,2);
INSERT INTO detalheEncomendaFornecedor (detalheEncomendaFornecedorID,detalheEncomendaFornecedorCodFatura,detalheEncomendaFornecedorRefProduto,detalheEncomendaFornecedorQuantidade) VALUES (32,19,8,14);
INSERT INTO detalheEncomendaFornecedor (detalheEncomendaFornecedorID,detalheEncomendaFornecedorCodFatura,detalheEncomendaFornecedorRefProduto,detalheEncomendaFornecedorQuantidade) VALUES (10,37,5,20);
INSERT INTO detalheEncomendaFornecedor (detalheEncomendaFornecedorID,detalheEncomendaFornecedorCodFatura,detalheEncomendaFornecedorRefProduto,detalheEncomendaFornecedorQuantidade) VALUES (50,7,5,10);
INSERT INTO detalheEncomendaFornecedor (detalheEncomendaFornecedorID,detalheEncomendaFornecedorCodFatura,detalheEncomendaFornecedorRefProduto,detalheEncomendaFornecedorQuantidade) VALUES (43,41,7,5);
INSERT INTO detalheEncomendaFornecedor (detalheEncomendaFornecedorID,detalheEncomendaFornecedorCodFatura,detalheEncomendaFornecedorRefProduto,detalheEncomendaFornecedorQuantidade) VALUES (16,35,7,7);
INSERT INTO detalheEncomendaFornecedor (detalheEncomendaFornecedorID,detalheEncomendaFornecedorCodFatura,detalheEncomendaFornecedorRefProduto,detalheEncomendaFornecedorQuantidade) VALUES (38,34,9,10);
INSERT INTO detalheEncomendaFornecedor (detalheEncomendaFornecedorID,detalheEncomendaFornecedorCodFatura,detalheEncomendaFornecedorRefProduto,detalheEncomendaFornecedorQuantidade) VALUES (41,49,6,6);
INSERT INTO detalheEncomendaFornecedor (detalheEncomendaFornecedorID,detalheEncomendaFornecedorCodFatura,detalheEncomendaFornecedorRefProduto,detalheEncomendaFornecedorQuantidade) VALUES (18,19,2,20);
INSERT INTO detalheEncomendaFornecedor (detalheEncomendaFornecedorID,detalheEncomendaFornecedorCodFatura,detalheEncomendaFornecedorRefProduto,detalheEncomendaFornecedorQuantidade) VALUES (3,28,2,18);
INSERT INTO detalheEncomendaFornecedor (detalheEncomendaFornecedorID,detalheEncomendaFornecedorCodFatura,detalheEncomendaFornecedorRefProduto,detalheEncomendaFornecedorQuantidade) VALUES (15,15,7,4);
INSERT INTO detalheEncomendaFornecedor (detalheEncomendaFornecedorID,detalheEncomendaFornecedorCodFatura,detalheEncomendaFornecedorRefProduto,detalheEncomendaFornecedorQuantidade) VALUES (2,5,1,5);
INSERT INTO detalheEncomendaFornecedor (detalheEncomendaFornecedorID,detalheEncomendaFornecedorCodFatura,detalheEncomendaFornecedorRefProduto,detalheEncomendaFornecedorQuantidade) VALUES (1,37,5,10);
INSERT INTO detalheEncomendaFornecedor (detalheEncomendaFornecedorID,detalheEncomendaFornecedorCodFatura,detalheEncomendaFornecedorRefProduto,detalheEncomendaFornecedorQuantidade) VALUES (7,40,1,20);
INSERT INTO detalheEncomendaFornecedor (detalheEncomendaFornecedorID,detalheEncomendaFornecedorCodFatura,detalheEncomendaFornecedorRefProduto,detalheEncomendaFornecedorQuantidade) VALUES (38,16,2,10);
INSERT INTO detalheEncomendaFornecedor (detalheEncomendaFornecedorID,detalheEncomendaFornecedorCodFatura,detalheEncomendaFornecedorRefProduto,detalheEncomendaFornecedorQuantidade) VALUES (30,29,2,18);
INSERT INTO detalheEncomendaFornecedor (detalheEncomendaFornecedorID,detalheEncomendaFornecedorCodFatura,detalheEncomendaFornecedorRefProduto,detalheEncomendaFornecedorQuantidade) VALUES (21,47,4,2);
INSERT INTO detalheEncomendaFornecedor (detalheEncomendaFornecedorID,detalheEncomendaFornecedorCodFatura,detalheEncomendaFornecedorRefProduto,detalheEncomendaFornecedorQuantidade) VALUES (19,23,6,2);
INSERT INTO detalheEncomendaFornecedor (detalheEncomendaFornecedorID,detalheEncomendaFornecedorCodFatura,detalheEncomendaFornecedorRefProduto,detalheEncomendaFornecedorQuantidade) VALUES (42,17,9,4);
INSERT INTO detalheEncomendaFornecedor (detalheEncomendaFornecedorID,detalheEncomendaFornecedorCodFatura,detalheEncomendaFornecedorRefProduto,detalheEncomendaFornecedorQuantidade) VALUES (26,30,4,12);
INSERT INTO detalheEncomendaFornecedor (detalheEncomendaFornecedorID,detalheEncomendaFornecedorCodFatura,detalheEncomendaFornecedorRefProduto,detalheEncomendaFornecedorQuantidade) VALUES (48,2,6,11);

/*************************************************
    INSERE NA TABELA DIVERSOSESTADOS
*************************************************/
INSERT INTO diversosEstados (diversosEstadosIDEstado, diversosEstadosNome) VALUES (1, 'Pendente');
INSERT INTO diversosEstados (diversosEstadosIDEstado, diversosEstadosNome) VALUES (2, 'Confirmado');
INSERT INTO diversosEstados (diversosEstadosIDEstado, diversosEstadosNome) VALUES (3, 'Em preparação');
INSERT INTO diversosEstados (diversosEstadosIDEstado, diversosEstadosNome) VALUES (4, 'Em Entrega');
INSERT INTO diversosEstados (diversosEstadosIDEstado, diversosEstadosNome) VALUES (5, 'Entregue');

/*---------------------------------------------------
                        Query's
-----------------------------------------------------*/

SELECT m.menuRefPrato as idPrato, m.menuNome as nomePrato, mp.materiaPrimaRefProduto as idProduto, mp.materiaPrimaNome as nomeProduto
FROM menuMateriais mm, materiaPrima mp, menu m
WHERE m.menuRefPrato =  menumateriaisrefprato and  mp.materiaPrimaRefProduto = menumateriaisrefproduto
ORDER BY m.menuRefPrato

SELECT menuRefPrato, menuNome, menuDescricao, menuPrecoPVP FROM Menu where EmUso IS NOT NULL

SELECT * FROM TIPOeSTADOS
SELECT * FROM MENU
SELECT menuRefPrato, menuNome, menuDescricao, menuPrecoPVP FROM Menu where EmUso IS NULL

/*********************************************************************************
    QUERY PARA PROCURAR TODOS OS PEDIDOS DE UM DETERMINADO CLIENTE (HISTÓRICO)   
**********************************************************************************/
SELECT encomendasIDEncomenda, encomendasDataHora, menuNome FROM encomendas 
                                                            LEFT JOIN menu ON menuRefPrato=encomendasRefPrato 
                                                            WHERE encomendasNCliente=85

/*********************************************************************************
                    QUERY PARA PROCURAR O CLIENTE PELO NOME   
**********************************************************************************/
SELECT clienteNCliente, clienteEmail, clienteTelemovel FROM cliente WHERE clienteNome='Salvador'

/*********************************************************************************
                    QUERY PARA ATUALIZAR DADOS DO CLIENTE   
**********************************************************************************/
UPDATE cliente SET clienteEmail='salvador@email.com', clienteTelemovel=987654322 WHERE clienteNCliente=1


/*---------------------------------------------------
                        View's
-----------------------------------------------------*/
/* APAGAR VIEW
DROP VIEW mostraDetalhes*/

/* CRIAR A VIEW que mostra todos os pratos da encomenda */
CREATE VIEW mostraDetalhes AS

SELECT m.menuNome as menu, d.detalheEncomendaPreco as preco, d.detalheEncomendaQuantidade as quantidade, d.detalheEncomendaIDEncomenda as idEncomenda, e.encomendasDataHora as dataHora, de.diversosEstadosNome as estado, te.tipoEstadosIDEstadoDiverso as idEstado
FROM detalheEncomenda d, menu m, encomendas e, diversosEstados de, tipoEstados te
WHERE d.detalheEncomendaRefPrato = m.menuRefPrato and d.detalheEncomendaIDEncomenda = e.encomendasIDEncomenda and tipoEstadosIDEstado = d.detalheEncomendaIDEncomenda and de.diversosEstadosIDESTADO = te.tipoEstadosIDEstadoDiverso AND te.tipoEstadosIDEstadoDiverso > 0 AND te.tipoEstadosIDEstadoDiverso < 4

/*  SELECIONAR DETALHES */
SELECT * FROM mostraDetalhes WHERE idEncomenda=4
SELECT COUNT(*) FROM mostraDetalhes

<<<<<<< Updated upstream
SELECT m.menuNome as menu, d.detalheEncomendaPreco as preco, d.detalheEncomendaQuantidade as quantidade, d.detalheEncomendaIDEncomenda as idEncomenda, e.encomendasDataHora as dataHora, de.diversosEstadosNome as estado, te.tipoEstadosIDEstadoDiverso as idEstado
FROM detalheEncomenda d, menu m, encomendas e, diversosEstados de, tipoEstados te
WHERE d.detalheEncomendaRefPrato = m.menuRefPrato and d.detalheEncomendaIDEncomenda = e.encomendasIDEncomenda and tipoEstadosIDEstado = d.detalheEncomendaIDEncomenda and de.diversosEstadosIDESTADO = te.tipoEstadosIDEstadoDiverso AND te.tipoEstadosIDEstadoDiverso > 0 AND te.tipoEstadosIDEstadoDiverso < 4
=======
DROP VIEW materiaisPrato

CREATE VIEW materiaisPrato AS
SELECT m.menuRefPrato as idPrato, m.menuNome as nomePrato, mp.materiaPrimaRefProduto as idProduto, mp.materiaPrimaNome as nomeProduto, mm.quantidade
FROM menuMateriais mm, materiaPrima mp, menu m
WHERE m.menuRefPrato =  menumateriaisrefprato and  mp.materiaPrimaRefProduto = menumateriaisrefproduto
ORDER BY m.menuRefPrato

SELECT COUNT(*) FROM materiaisPrato

SELECT * FROM materiaisPrato WHERE idPrato = 1
>>>>>>> Stashed changes
