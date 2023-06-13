const String farmTable = 'FARM';
const String animalTable = 'ANIMAL';

const String farmTableScript = '''
    CREATE TABLE $farmTable (
      farm_id INTEGER PRIMARY KEY AUTOINCREMENT,
      farm_name TEXT NOT NULL
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
    SELECT farm_id, farm_name, quantity.COUNT as COUNT from $farmTable
      LEFT JOIN (SELECT animal_farm_id, COUNT(*) as COUNT from $animalTable GROUP BY animal_farm_id) quantity 
      ON farm_id = animal_farm_id
  ''';
