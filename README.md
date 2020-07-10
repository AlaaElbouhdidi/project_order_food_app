# OrderAndEat

OrderAndEat ist eine Essenslieferapp, in der man sich ein Konto anlegt, sich authentifiziert und im Anschluss dann Essen bestellen kann.


*Ein SWIFT Projekt von Alaa El Bouhdidi und Yasin Eraslan*

**Featureliste**:

*  Registrierung eines neuen Users(Daten werden im FireStore abgespeichert)
*  Authentifizierung mit Firebase(Login/Logout)
*  Anzeige des User Profils(Kontaktdaten, Adresse) und Editieren des User Profils
*  Anzeige der Gerichte(Wird geholt aus FireStore Database)
*  Auflisten der Bewertungen von Beutzern bei der Beschreibung einer Speise
*  Jeder Benutzer kann eine Bewertung mit Stern-Skala und einem Text selbst verfassen 
*  Essen einer Bestellkarte hinzufügen(Warenkorb)
*  Anzeige der Gerichte in der Bestellkarte und der totale Preis
*  Möglichkeit zum Ändern der Menge eines Gerichts oder direktes Löschen aus der Bestellkarte
*  Auswahl der Zahlungsmethode
*  Nach Abschicken der Bestellung wird die Bestellung in der FireStore Database gepeichert
*  Man kann sich alle Bestellungen zu einem jeweiligen user im User Profil anzeigen lassen



**Vorgehensweise**:

Wir haben uns am Anfang überlegt wie wir unsere Daten abspeichern sollten und haben uns dann für den FireStore von FireBase entschieden. Danach haben wir einige Views entwickelt um
uns zu veranschaulichen was für Use Cases genau implementiert werden müssen. Dann haben wir mit der Implementierung der Authentifizierung begonnen. Da wir den FireStore von FireBase
benutzen wollten, haben wir auch FireBase genutzt um die Authentifizierung zu implementieren. Die Dokumenation zu FireBase ist sehr gut geschrieben, sodass wir sehr schnell erfolgreich
waren bei der Implementierung der Authentifizierung. Zum Schluss blieb eigentlich nur noch die Implementierung der Controller um Daten vom FireStore zu bekommen für die Gerichte, für
Bestellkarte und für das UserProfil und schlussendlich für das Speichern der Bestellung.



**Verwendete Technlogien** :

Neben SWIFT und SWIFT UI haben wir noch weiterhin FireBase für das Speichern der Daten und zur Authentifizierung genutzt. Außerdem wurde SDWebImageSwiftUI auch eingesetzt. 
Diese Bibliothek bietet einen asynchronen Image-Downloader mit Cache-Unterstützung.



**Fazit von Yasin**:

Meiner Meinung nach war der Kurs sehr gut aufgebaut und die Grundlagen sehr gut aufgezeigt und erklärt, sodass wir nur noch das Gelernte anwenden sollten, 
für mich war das Arbeiten mit SWIFT sehr schwer, da ich mich allgemein auf Backend Programmierung spezialisiert habe in Java und es ein schwerer Übergang war.  

**Fazit von Alaa**:

- SwiftUI erleichtert vieles, sorgt er doch bei einer Änderung für eine automatische Aktualisierung der View. 
- in Xcode 11 integriertes graphisches Werkzeug zur Gestaltung des UIs macht es UI-Entwicklern ganz einfach mit SwiftUI eine Benutzeroberfläche zu gestalten.
- Der Kurs hätte meiner Meinung nach einen Überblick der sämtlichen UI-Elemente und ihre Eigenschaften behandeln sollen, unter anderem eine Dokumentation über Modifiers. 
