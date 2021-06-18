# CagnotteEnLigne

Vous allez créer un projet de paiement collaboratif. Ce sera une preuve de concept pour un site type leetchi, mais pourquoi pas aussi pour des paris entre potes, des courses communes, etc.\
Diagramme :
Projet collaboratif paiement - Google Drive

Maquettes HTML : 🦄
simplon-roanne / paiement collaboratif · GitLab

Analyse des besoins :
En tant qu'utilisateur je crée une campagne de financement collaborative avec les champs suivants :
Nom de la campagne : 120 caractères maximum
Contenu de la campagne : texte libre via éditeur markdown
Objectif de cagnotte : nombre qui servira de simple indicateur
Nom
Email
En tant qu'utilisateur j'accède à une campagne partagée par l'auteur de la campagne via URL sécurisée et aléatoire
(ID de la campagne encrypté)
En tant que participant je peux modifier le budget
En tant que participant je paye n'importe quel montant. En plus de ma carte, je suis invité à saisir mon email. Le paiement est ensuite comptabilisé dans la cagnotte et visible dans une liste.


Note importante

Il y aura une limitation majeure : le destinataire des paiements ne sera pas dynamique : ce sera une seule personne pour toute l'application. Après avoir réussi à terminer ce projet, il serait possible de le continuer avec un système qui relie les créateurs de campagnes avec leur compte bancaire. Mais nous n'irons pas jusque là dans un premier temps.
