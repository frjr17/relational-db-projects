DROP DATABASE universe;
CREATE DATABASE universe;

\c universe;

CREATE TABLE galaxy(
  galaxy_id SERIAL NOT NULL UNIQUE PRIMARY KEY,
  name VARCHAR(60) UNIQUE,
  has_life BOOLEAN NOT NULL,
  age_in_millions_of_years INT NOT NULL,
  distance_from_earth NUMERIC(5,1),
  description TEXT
);

INSERT INTO galaxy(name,has_life,age_in_millions_of_years,distance_from_earth,description) VALUES(
  'GALAXY 1',
  true,
  102942,
  2938.3,
  'A tiny Galaxy'
), (
  'GALAXY 2',
  false,
  102944,
  2238.3,
  'A bigger Galaxy'
),(
  'GALAXY 3',
  false,
  12391,
  3984.5,
  'A more big Galaxy'
),(
  'GALAXY 4',
  true,
  12934,
  2018.3,
  'Not an old galaxy, but there is life in there.'
),(
  'GALAXY 5',
  true,
  1239321,
  2912.3,
  'Another huge galaxy'
),(
  'GALAXY 6',
  true,
  123491,
  6430.3,
  'Not for humans'
);

CREATE TABLE star(
  star_id SERIAL NOT NULL UNIQUE PRIMARY KEY,
  name VARCHAR(60) UNIQUE,
  has_life BOOLEAN NOT NULL,
  age_in_millions_of_years INT NOT NULL,
  distance_from_earth NUMERIC(5,1),
  description TEXT,
  galaxy_id INT, 
  FOREIGN KEY (galaxy_id) REFERENCES galaxy(galaxy_id)
);
INSERT INTO star(name,has_life,age_in_millions_of_years,distance_from_earth,description,galaxy_id) VALUES(
  'STAR 1',
  true,
  102942,
  2938.3,
  'A tiny STAR',
  1
), (
  'STAR 2',
  false,
  102944,
  2238.3,
  'A bigger STAR',
  2
),(
  'STAR 3',
  false,
  12391,
  3984.5,
  'A more big STAR',
  3
),(
  'STAR 4',
  true,
  12934,
  2018.3,
  'Not an old STAR, but there is life in there.',
  4
),(
  'STAR 5',
  true,
  1239321,
  2912.3,
  'Another huge STAR',
  5
),(
  'STAR 6',
  true,
  123491,
  6430.3,
  'Not for humans',
  6
);

CREATE TABLE planet(
  planet_id SERIAL NOT NULL UNIQUE PRIMARY KEY,
  name VARCHAR(60) UNIQUE,
  has_life BOOLEAN NOT NULL,
  age_in_millions_of_years INT NOT NULL,
  distance_from_earth NUMERIC(5,1),
  description TEXT,
  star_id INT,
   FOREIGN KEY (star_id) REFERENCES star(star_id)
);
INSERT INTO planet(name,has_life,age_in_millions_of_years,distance_from_earth,description,star_id) VALUES(
  'planet 1',
  true,
  102942,
  2938.3,
  'A tiny planet',
  1
), (
  'planet 2',
  false,
  102944,
  2238.3,
  'A bigger planet',
  2
),(
  'planet 3',
  false,
  12391,
  3984.5,
  'A more big planet',
  3
),(
  'planet 4',
  true,
  12934,
  2018.3,
  'Not an old planet, but there is life in there.',
  4
),(
  'planet 5',
  true,
  1239321,
  2912.3,
  'Another huge planet',
  5
),(
  'planet 6',
  true,
  123491,
  6430.3,
  'Not for humans',
  6
),(
  'planet 7',
  true,
  102942,
  2938.3,
  'A tiny planet',
  1
), (
  'planet 8',
  false,
  102944,
  2238.3,
  'A bigger planet',
  2
),(
  'planet 9',
  false,
  12391,
  3984.5,
  'A more big planet',
  3
),(
  'planet 10',
  true,
  12934,
  2018.3,
  'Not an old planet, but there is life in there.',
  4
),(
  'planet 11',
  true,
  1239321,
  2912.3,
  'Another huge planet',
  5
),(
  'planet 12',
  true,
  123491,
  6430.3,
  'Not for humans',
  6
);

CREATE TABLE moon(
  moon_id SERIAL NOT NULL UNIQUE PRIMARY KEY,
  name VARCHAR(60) UNIQUE,
  has_life BOOLEAN NOT NULL,
  age_in_millions_of_years INT NOT NULL,
  distance_from_earth NUMERIC(5,1),
  description TEXT,
  planet_id INT,
   FOREIGN KEY (planet_id) REFERENCES planet(planet_id)
);
INSERT INTO moon(name,has_life,age_in_millions_of_years,distance_from_earth,description,planet_id) VALUES(
  'moon 1',
  true,
  102942,
  2938.3,
  'A tiny moon',
  1
), (
  'moon 2',
  false,
  102944,
  2238.3,
  'A bigger moon',
  2
),(
  'moon 3',
  false,
  12391,
  3984.5,
  'A more big moon',
  3
),(
  'moon 4',
  true,
  12934,
  2018.3,
  'Not an old moon, but there is life in there.',
  4
),(
  'moon 5',
  true,
  1239321,
  2912.3,
  'Another huge moon',
  5
),(
  'moon 6',
  true,
  123491,
  6430.3,
  'Not for humans',
  6
),(
  'moon 7',
  true,
  102942,
  2938.3,
  'A tiny moon',
  7
), (
  'moon 8',
  false,
  102944,
  2238.3,
  'A bigger moon',
  8
),(
  'moon 9',
  false,
  12391,
  3984.5,
  'A more big moon',
  9
),(
  'moon 10',
  true,
  12934,
  2018.3,
  'Not an old moon, but there is life in there.',
  10
),(
  'moon 11',
  true,
  1239321,
  2912.3,
  'Another huge moon',
  11
),(
  'moon 12',
  true,
  123491,
  6430.3,
  'Not for humans',
  12
),(
  'moon 13',
  true,
  102942,
  2938.3,
  'A tiny moon',
  1
), (
  'moon 14',
  false,
  102944,
  2238.3,
  'A bigger moon',
  2
),(
  'moon 15',
  false,
  12391,
  3984.5,
  'A more big moon',
  3
),(
  'moon 16',
  true,
  12934,
  2018.3,
  'Not an old moon, but there is life in there.',
  4
),(
  'moon 17',
  true,
  1239321,
  2912.3,
  'Another huge moon',
  5
),(
  'moon 18',
  true,
  123491,
  6430.3,
  'Not for humans',
  6
),(
  'moon 19',
  true,
  102942,
  2938.3,
  'A tiny moon',
  7
), (
  'moon 20',
  false,
  102944,
  2238.3,
  'A bigger moon',
  8
);

CREATE TABLE satelite(
  satelite_id SERIAL NOT NULL UNIQUE PRIMARY KEY,
  name VARCHAR(60) UNIQUE,
  has_life BOOLEAN NOT NULL,
  age_in_millions_of_years INT NOT NULL ,
  distance_from_earth NUMERIC(5,1),
  description TEXT,
  planet_id INT,
   FOREIGN KEY (planet_id) REFERENCES planet(planet_id)
);

INSERT INTO satelite(name,has_life,age_in_millions_of_years,distance_from_earth,description,planet_id) VALUES(
  'satelite 1',
  true,
  102942,
  2938.3,
  'A tiny satelite',
  1
), (
  'satelite 2',
  false,
  102944,
  2238.3,
  'A bigger satelite',
  2
),(
  'satelite 3',
  false,
  12391,
  3984.5,
  'A more big satelite',
  3
);