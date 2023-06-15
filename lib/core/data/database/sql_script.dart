const String farmTable = 'FARM';
const String animalTable = 'ANIMAL';

const String farmTableScript = '''
    CREATE TABLE $farmTable (
      farm_id INTEGER PRIMARY KEY AUTOINCREMENT,
      farm_name TEXT NOT NULL,
      quantity INTEGER
    )
  ''';

const String animalTableScript = '''
    CREATE TABLE $animalTable (
      animal_id INTEGER PRIMARY KEY AUTOINCREMENT,
      animal_farm_id INTEGER NOT NULL,
      animal_name TEXT NOT NULL,
      animal_tag TEXT NOT NULL,
      FOREIGN KEY (animal_farm_id) REFERENCES FARM (farm_id)
      ON DELETE CASCADE
    )
  ''';

const String selectFarmTableScript = '''
    SELECT * FROM $farmTable
  ''';
