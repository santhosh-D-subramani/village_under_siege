
const appName = 'Village Under Siege';

List<String> normalVillagers = [
  'doctor',
  'police',
  'Rambo',
  'lover',
  'saint',
  'normal people'
];
List<String> mafia = [
  'god father',
  'normal mafia'
];



const String rules = '''
Roles:
1. Normal Villagers
   a) Doctor
   b) Police
   c) Rambo
   d) Lover
   e) Saint
   f) Normal People
2. Mafia
   a) God Father
   b) Normal Mafia

Rules:
1. Day Active:
   - Villagers can guess Mafia and remove them with majority.
2. Night:
   1. All Mafias are active and can remove any one of others.
   2. God Father Power: Can remove any one and nullify (role block) any one's power (tells to moderator).
   3. Doctor Night Active: Can guess and save any one (random) (tells to moderator).
   4. Police Power:
      1. Can request data (villager/mafia) from moderator but God Father won’t be exposed as mafia, will be told as villager.

5. Rambo:
   1. Only has one bullet, can remove any one person (can use or not).
6. Lover (2 people):
   1. If one lover is guessed/dies, both die.
7. Saint:
   1. Killed in night, no problem.
   2. If voted as mafia, all framing him as mafia die.

General:
1. No one can see others' roles.
2. Mafia wins: More/equal count as villagers.
3. Villagers win: All mafia die.
4. Vote order at night: God Father/Mafia.
''';

