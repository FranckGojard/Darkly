# Rapport de Vulnérabilité : Injection de Paramètre dans une Redirection

## Nom de la Faille
**Injection de Paramètre dans une Redirection**

## Description
Cette faille permet à un attaquant de manipuler le paramètre `site` dans l'URL pour accéder à des ressources non autorisées ou révéler des informations sensibles, comme un flag. Lorsque la valeur du paramètre `site` ne correspond à aucune redirection valide, le site retourne le flag au lieu de gérer proprement l'erreur.

## Comment Exploiter la Faille
1. **Étape 1** : Identifiez le lien de redirection dans le code HTML du site. Par exemple :
   ```html
   <a href="index.php?page=redirect&amp;site=facebook" class="icon fa-facebook"></a>
   ```
   Ce lien redirige normalement vers Facebook.

2. **Étape 2** : Modifiez la valeur du paramètre `site` dans l'URL pour une valeur qui ne correspond à aucune redirection valide. Par exemple, remplacez `facebook` par `flag` :
   ```
   index.php?page=redirect&site=flag
   ```

3. **Étape 3** : Soumettez la requête. Si la redirection n'existe pas, le site retourne le flag :
   ```
   b9e775a0291fed784a2d9680fcfad7edd6b8cdf87648da647aaf4bba288bcab3
   ```

## Comment Résoudre la Faille
Pour corriger cette vulnérabilité, suivez les étapes suivantes :

- **Validation des Entrées** : Validez et filtrez les valeurs du paramètre `site` pour vous assurer qu'elles correspondent à des valeurs attendues.
- **Liste Blanche** : Utilisez une liste blanche de valeurs autorisées pour le paramètre `site`.
- **Gestion des Erreurs** : Redirigez vers une page d'erreur générique si la valeur du paramètre `site` n'est pas valide.
- **Journalisation** : Journalisez les tentatives d'accès à des redirections non valides pour détecter les activités suspectes.

## Exemple de Code Sécurisé
```php
<?php
$allowed_sites = [
    'facebook' => 'https://www.facebook.com',
    'twitter'  => 'https://www.twitter.com',
    // Ajoutez d'autres sites autorisés ici
];

$site = $_GET['site'];

if (array_key_exists($site, $allowed_sites)) {
    header('Location: ' . $allowed_sites[$site]);
    exit();
} else {
    // Redirigez vers une page d'erreur générique
    header('Location: /error.php');
    exit();
}
?>
```

## Conclusion
Cette vulnérabilité met en évidence l'importance de valider les entrées utilisateur et de bien gérer les erreurs. En implémentant les corrections ci-dessus, vous pouvez sécuriser votre application contre ce type de faille.