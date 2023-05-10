<br />
<div align="center">
    <img src="https://github.com/ugo-prenat/maating/assets/53117589/e5712535-d8fb-491c-9ca8-be13381d5d03" width="200">

<h1 align="center">Maating</h1>

  <p align="center">
    Alone and want to train ?
    <br />
    Find your mate !
    <br />
  </p>
</div>

<br />

Maating est une application mobile tourné autour de la pratique sportive, l'objectif est de favoriser les rencontres entre les passionnés de sport en participant à des évènements autour de chez vous.

<br />
<br />

## Fonctionnalités principales

* Carte intéractive pour découvrir les évènements sportifs autour de chez vous
* Inscription simplifié
  - Vous ne venez pas tout seul ? Réservation de plusieurs places pour vous et vos amis 
* Création d'évènements
* Controlle de l'accès aux évènements
    - Gestion d'évènements privés/publiques 
* Système de notation et commentaires entre utilisateurs
    - Garantie de la bienveillance
* Cross platform
  - Supporté sous IOS, Android, Windows, macOS et Linux.

<br />

## Technologies utilisées
* [Flutter](https://flutter.dev)
* [NodeJS](https://nodejs.org/en)
* [Express](https://expressjs.com/fr)
* [MongoDB](https://www.mongodb.com/fr-fr)

<br />

## Lancer l'application

```bash
# Cloner le repository
$ git clone https://github.com/ugo-prenat/maating.git
```
Lancer le frontend :
```bash
# Aller dans le répertoire frontend
$ cd maating/frontend

# Installer les dépendances
$ flutter packages get

# Lancer l'application
$ flutter run
```
Lancer le backend :
```bash
# Aller dans le répertoire backend
$ cd maating/backend

# Installer les dépendances
$ npm install

# Lancer le serveur
$ npm start
```
> Les requêtes sont envoyées en local au backend via l'adresse http://10.0.2.2:4000

<br />

:warning: Lancer le backend localement comme présenté ci-dessus ne fonctionnera que pour exécuter l'application depuis un émulateur sur votre ordinateur.

Pour exécuter l'application depuis un téléphone physique, il faut indiquer au frontend d'envoyer les requêtes vers un backend hébergé.

Pour lancer l'application depuis un téléphone physique :
```bash
# Aller dans le répertoire frontend
cd maating/frontend

# Lancer l'application avec la variable BACK_ENV égale à "remote"
flutter run --dart-define="BACK_ENV=remote" 
```
Désormais, les requêtes seront envoyées à l'adresse [maating-api.up.railway.app](https://maating-api.up.railway.app)
> **Note**
> La version du backend disponible à cette adresse est celle de la branch main

<br>

## Exécution des tests

#### Front
```bash
# Aller dans le répertoire frontend
cd frontend

# Exécuter les tests d'intégration
flutter test integration_test

# Exécuter les tests unitaires
flutter test test
```

#### Back
```bash
# Aller dans le répertoire backend
cd backend

# Exécuter les tests unitaires
npm test
```

## Rapport d'incident
...

<br>
<br>
<br>
<br>

:soccer:

