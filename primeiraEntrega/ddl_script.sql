-- Projeto - Fase 1 (Grupo 5)
-- Junto com seu grupo, faça o Esquema Relacional em SQL, 
-- usando as regras de mapeamento ER para Relacional vistas em video-aula, 
-- para o Esquema Entidades e Relacionamentos de uma Universidade em anexo. 

-- Cria a tabela de Laboratorio de Pesquisa, onde a primary key eh o codigo
CREATE TABLE LaboratorioDePesquisa(
    codigo INT NOT NULL,
    localizacao VARCHAR(30) NOT NULL,
    nome VARCHAR(50) NOT NULL,
    PRIMARY KEY(codigo)
);

-- Cria a tabela de Posto de Trabalho, fazendo referencia ao Laboratorio de Pesquisa
-- ON DELETE CASCADE Pois um Posto de Trabalho so existe caso um Laboratorio de Pesquisa exista
CREATE TABLE PostoDeTrabalho(
    codigo INT NOT NULL,
    nome VARCHAR(50) NOT NULL,
    recursos VARCHAR(50) NOT NULL,
    impressoras VARCHAR(50) NOT NULL,
    descricao VARCHAR(255) NOT NULL,
    codigo_laboratorio INT NOT NULL,
    PRIMARY KEY(codigo, codigo_laboratorio),
    CONSTRAINT fk_pertence_a_laboratorio FOREIGN KEY(codigo_laboratorio)
        REFERENCES LaboratorioDePesquisa(codigo)
            ON DELETE CASCADE
);

-- Cria a tabela de Linha de Pesquisa, onde a primary key eh o codigo
CREATE TABLE LinhaDePesquisa(
    codigo INT NOT NULL,
    codigo_cnpq_area INT NOT NULL,
    nome_area VARCHAR(30) NOT NULL,
    nome VARCHAR(50) NOT NULL,
    codigo_cnpq_subarea INT NOT NULL,
    nome_subarea VARCHAR(30) NOT NULL,
    descricao VARCHAR(255) NOT NULL,
    PRIMARY KEY(codigo)
);

-- Cria a tabela de Autor, onde a primary key eh a sua matricula
CREATE TABLE Autor(
    matricula INT NOT NULL,
    nome VARCHAR(255) NOT NULL,
    data_nascimento DATE NOT NULL,
    PRIMARY KEY(matricula)
);

-- Cria a tabela de Professor, onde a primary key eh a sua matricula
-- Referencia o Autor
CREATE TABLE Professor(
    matricula INT NOT NULL,
    titulacao VARCHAR(50) NOT NULL,
    PRIMARY KEY(matricula),
    CONSTRAINT fk_matricula_autor_professor FOREIGN KEY(matricula)
        REFERENCES Autor(matricula)
);

-- Cria a tabela de Aluno, onde a primary key eh a sua matricula
-- Referencia o Autor
CREATE TABLE Aluno(
    matricula INT NOT NULL,
    nivel_estudo VARCHAR(50) NOT NULL,
    valor_bolsa DECIMAL(10,2),
    PRIMARY KEY(matricula),
    CONSTRAINT fk_matricula_autor_aluno FOREIGN KEY(matricula)
        REFERENCES Autor(matricula)
);

-- Cria a tabela de Agente Financiador, onde a primary key eh o codigo
CREATE TABLE AgenteFinanciador(
    codigo INT NOT NULL,
    nome VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    PRIMARY KEY(codigo)
);

-- Cria a tabela de Projeto, onde a primary key eh a sua matricula
-- Referencia Professor e Linha de Pesquisa
CREATE TABLE Projeto(
    codigo INT NOT NULL,
    titulo VARCHAR(30) NOT NULL,
    descricao VARCHAR(255) NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE NOT NULL,
    orcamento DECIMAL(10, 2),
    coordenador INT NOT NULL,
    linha_pesquisa INT NOT NULL,
    PRIMARY KEY(codigo),
    CONSTRAINT fk_codigo_professor FOREIGN KEY(coordenador)
        REFERENCES Professor(matricula),
    CONSTRAINT fk_linha_pesquisa_associada FOREIGN KEY(linha_pesquisa)
        REFERENCES LinhaDePesquisa(codigo)
);

-- Cria a tabela de Trabalho, onde a primary key eh o codigo
-- Referencia o Projeto
CREATE TABLE Trabalho(
    codigo INT NOT NULL,
    codigo_projeto INT NOT NULL,
    PRIMARY KEY(codigo),
    CONSTRAINT fk_projeto_gerador FOREIGN KEY(codigo_projeto)
        REFERENCES Projeto(codigo)
);

-- Cria a tabela de Publicacao, onde a primary key eh o codigo
-- Referencia o Trabalho
CREATE TABLE Publicacao(
    codigo INT NOT NULL,
    titulo VARCHAR(255) NOT NULL,
    veiculo VARCHAR(255) NOT NULL,
    ano_publicacao NUMBER(4) NOT NULL,
    PRIMARY KEY(codigo),
    CONSTRAINT fk_codigo_trabalho_publicacao FOREIGN KEY(codigo)
        REFERENCES Trabalho(codigo)
);

-- Cria a tabela de Patente, onde a primary key eh o codigo
-- Referencia o Trabalho
CREATE TABLE Patente(
    codigo INT NOT NULL,
    numero_registro INT NOT NULL,
    descricao VARCHAR(255),
    PRIMARY KEY(codigo),
    CONSTRAINT fk_codigo_trabalho_patente FOREIGN KEY(codigo)
        REFERENCES Trabalho(codigo)
);

-- Cria a tabela de Departamento, onde a primary key eh o codigo
-- Referencia o Professor
CREATE TABLE Departamento(
    codigo INT NOT NULL,
    nome VARCHAR(255) NOT NULL,
    chefe INT NOT NULL UNIQUE,
    PRIMARY KEY(codigo),
    CONSTRAINT fk_professor_chefe FOREIGN KEY(chefe)
        REFERENCES Professor(matricula)
);

-- Relacoes

-- Cria a tabela de relacao de Participacao em Pesquisa, onde a primary key eh o codigo
-- Referencia: Linha de Pesquisa, Aluno e Professor e usa suas chaves estrangeiras
CREATE TABLE ParticipacaoEmPesquisa(
    codigo NUMBER GENERATED ALWAYS AS IDENTITY,
    codigo_linha_pesquisa INT NOT NULL,
    codigo_aluno INT NULL UNIQUE,
    codigo_professor INT NULL,
    PRIMARY KEY(codigo),
    CONSTRAINT fk_codigo_linha_pesquisa FOREIGN KEY(codigo_linha_pesquisa)
        REFERENCES LinhaDePesquisa(codigo),
    CONSTRAINT fk_codigo_aluno_pesquisa FOREIGN KEY(codigo_aluno)
        REFERENCES Aluno(matricula),
    CONSTRAINT fk_codigo_professor_pesquisa FOREIGN KEY(codigo_professor)
        REFERENCES Professor(matricula)
);

-- Cria a tabela de relacao de Participacao em Projeto
-- Referencia: Linha de Pesquisa e Projeto e usa suas chaves estrangeiras
CREATE TABLE ParticipacaoEmProjeto(
    codigo NUMBER GENERATED ALWAYS AS IDENTITY,
    codigo_projeto INT NOT NULL,
    codigo_aluno INT NULL UNIQUE,
    codigo_professor INT NULL,
    CONSTRAINT fk_codigo_projeto FOREIGN KEY(codigo_projeto)
        REFERENCES Projeto(codigo),
    CONSTRAINT fk_codigo_aluno_projeto FOREIGN KEY(codigo_aluno)
        REFERENCES LinhaDePesquisa(codigo),
    CONSTRAINT fk_codigo_professor_projeto FOREIGN KEY(codigo_professor)
        REFERENCES LinhaDePesquisa(codigo)
);

-- Cria a tabela de relacao de Auoria, onde a primary key eh o codigo
-- Referencia: Trabalho e Autor e usa suas chaves estrangeiras
CREATE TABLE Autoria(
    codigo NUMBER GENERATED ALWAYS AS IDENTITY,
    codigo_trabalho INT NOT NULL,
    codigo_autor INT NOT NULL,
    PRIMARY KEY(codigo),
    CONSTRAINT fk_codigo_trabalho_autoria FOREIGN KEY(codigo_trabalho)
        REFERENCES Trabalho(codigo),
    CONSTRAINT fk_codigo_autor FOREIGN KEY(codigo_autor)
        REFERENCES Autor(matricula)
);

-- Cria a tabela de relacao de Financiamento, onde a primary key eh o codigo
-- Referencia: Projeto e Agente Financiador e usa suas chaves estrangeiras
CREATE TABLE Financiamento(
    codigo NUMBER GENERATED ALWAYS AS IDENTITY,
    codigo_projeto INT NOT NULL,
    codigo_agente INT NOT NULL,
    PRIMARY KEY(codigo),
    CONSTRAINT fk_codigo_projeto_financiamento FOREIGN KEY(codigo_projeto)
        REFERENCES Projeto(codigo),
    CONSTRAINT fk_codigo_agente_financiamento FOREIGN KEY(codigo_agente)
        REFERENCES AgenteFinanciador(codigo)
);

-- Cria a tabela de relacao de Realizacao de Projeto, onde a primary key eh o codigo
-- Referencia: Projeto e Laboratorio de Pesquisa e usa suas chaves estrangeiras
CREATE TABLE RealizacaoProjeto(
    codigo NUMBER GENERATED ALWAYS AS IDENTITY,
    codigo_projeto INT NOT NULL,
    codigo_laboratorio INT NOT NULL,
    PRIMARY KEY(codigo),
    CONSTRAINT fk_codigo_projeto_realizacao FOREIGN KEY(codigo_projeto)
        REFERENCES Projeto(codigo),
    CONSTRAINT fk_codigo_laboratorio_realizacao FOREIGN KEY(codigo_laboratorio)
        REFERENCES LaboratorioDePesquisa(codigo)
);

-- Cria a tabela de relacao de Lotacao, onde a primary key eh o codigo
-- Referencia: Professor e Departamento e usa suas chaves estrangeiras
CREATE TABLE Lotacao(
    codigo NUMBER GENERATED ALWAYS AS IDENTITY,
    codigo_professor INT NOT NULL UNIQUE,
    codigo_departamento INT NOT NULL,
    PRIMARY KEY(codigo),
    CONSTRAINT fk_codigo_professor_lotacao FOREIGN KEY(codigo_professor)
        REFERENCES Professor(matricula),
    CONSTRAINT fk_codigo_departamento_lotacao FOREIGN KEY(codigo_departamento)
        REFERENCES Departamento(codigo)
);

-- Cria a tabela de relacao de Telefone, onde a primary key sao: codigo, codigo_agente_financiador e codigo_departamento
-- Referencia: Agente Financiador e Departamento e usa suas chaves estrangeiras
-- ON DELETE CASCADE para Agente Financiador e Departamento pois o Telefone so existe nessas condicoes
CREATE TABLE Telefone(
    codigo NUMBER GENERATED ALWAYS AS IDENTITY,
    telefone VARCHAR(20) NOT NULL,
    codigo_agente_financiador INT NULL,
    codigo_departamento INT NULL,
    PRIMARY KEY(codigo, codigo_agente_financiador, codigo_departamento),
    CONSTRAINT fk_codigo_agente_financiador_telefone FOREIGN KEY(codigo_agente_financiador)
        REFERENCES AgenteFinanciador(codigo)
            ON DELETE CASCADE,
    CONSTRAINT fk_codigo_departamento_telefone FOREIGN KEY(codigo_departamento)
        REFERENCES Departamento(codigo)
            ON DELETE CASCADE,
    CONSTRAINT checa_codigo_entidade_telefone CHECK (
        (codigo_agente_financiador IS NOT NULL AND codigo_departamento IS NULL)
        OR
        (codigo_departamento IS NOT NULL AND codigo_agente_financiador IS NULL)
    )
);

-- Cria a tabela de relacao de Endereco, onde a primary key sao: codigo
-- Referencia: Agente Financiador e Departamento e usa suas chaves estrangeiras
-- ON DELETE CASCADE para Agente Financiador e Departamento pois o Telefone so existe nessas condicoes
CREATE TABLE Endereco(
    codigo NUMBER GENERATED ALWAYS AS IDENTITY,
    logradouro VARCHAR(255) NOT NULL,
    bairro VARCHAR(100) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    uf VARCHAR(2) NOT NULL,
    codigo_agente_financiador INT NULL,
    codigo_departamento INT NULL,
    PRIMARY KEY(codigo),
    CONSTRAINT fk_codigo_agente_financiador_endereco FOREIGN KEY(codigo_agente_financiador)
        REFERENCES AgenteFinanciador(codigo)
            ON DELETE CASCADE,
    CONSTRAINT fk_codigo_departamento_endereco FOREIGN KEY(codigo_departamento)
        REFERENCES Departamento(codigo)
            ON DELETE CASCADE,
    CONSTRAINT checa_codigo_entidade_endereco CHECK (
        (codigo_agente_financiador IS NOT NULL AND codigo_departamento IS NULL)
        OR
        (codigo_departamento IS NOT NULL AND codigo_agente_financiador IS NULL)
    )
);