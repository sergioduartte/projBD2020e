DELETE FROM Endereco;
DELETE FROM Departamento;
DELETE FROM RealizacaoProjeto;
DELETE FROM Professor;
DELETE FROM Aluno;
DELETE FROM Autor;

DELETE FROM Financiamento;

DELETE FROM Lotacao;
DELETE FROM ParticipacaoEmProjeto;
DELETE FROM Autoria;

DELETE FROM Patente;
DELETE FROM Publicacao;
DELETE FROM Trabalho;

DELETE FROM LinhaDePesquisa;
DELETE FROM AgenteFinanciador;
DELETE FROM Projeto;

DELETE FROM PostoDeTrabalho;
DELETE FROM LaboratorioDePesquisa;

-- table drops

DROP TABLE Departamento             CASCADE CONSTRAINTS;
DROP TABLE Professor                CASCADE CONSTRAINTS;
DROP TABLE Aluno                    CASCADE CONSTRAINTS;
DROP TABLE Autor                    CASCADE CONSTRAINTS;
DROP TABLE Patente                  CASCADE CONSTRAINTS;
DROP TABLE Publicacao               CASCADE CONSTRAINTS;
DROP TABLE Trabalho                 CASCADE CONSTRAINTS;
DROP TABLE LinhaDePesquisa          CASCADE CONSTRAINTS;
DROP TABLE AgenteFinanciador        CASCADE CONSTRAINTS;
DROP TABLE Projeto                  CASCADE CONSTRAINTS;
DROP TABLE PostoDeTrabalho          CASCADE CONSTRAINTS;
DROP TABLE LaboratorioDePesquisa    CASCADE CONSTRAINTS;
DROP TABLE Lotacao                  CASCADE CONSTRAINTS;
DROP TABLE ParticipacaoEmPesquisa   CASCADE CONSTRAINTS;
DROP TABLE ParticipacaoEmProjeto    CASCADE CONSTRAINTS;
DROP TABLE Telefone                 CASCADE CONSTRAINTS;
DROP TABLE Autoria                  CASCADE CONSTRAINTS;
DROP TABLE Endereco                 CASCADE CONSTRAINTS;
DROP TABLE Financiamento            CASCADE CONSTRAINTS;
DROP TABLE RealizacaoProjeto        CASCADE CONSTRAINTS;