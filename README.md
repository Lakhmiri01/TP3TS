# TP3 TS - La corrélation croisée Mesure de similarité entre deux signaux
### Encadré par: Prof AMMOUR ALAA

## Objectifs

- Comprendre la notion de la corrélation croisée et évaluer sa capacité dans la mesure de dépendance deux signaux.

- Evaluer l’efficacité de cette mesure en présence du bruit.

Commentaires : Il est à remarquer que ce TP traite en principe des signaux continus. Or, l’utilisation de Matlab suppose l’échantillonnage du signal. Il faudra donc être vigilant par rapport aux différences de traitement entre le temps continu et le temps discret.

Tracé des figures : toutes les figures devront être tracées avec les axes et les légendes des axes appropriés.

Travail demandé : un script Matlab commenté contenant le travail réalisé et des commentaires sur ce que vous avez compris et pas compris, ou sur ce qui vous a semblé intéressant ou pas, bref tout commentaire pertinent sur le TP.

# _Mesure de similarité entre deux signaux_
En traitement du signal, la corrélation croisée (aussi appelée covariance croisée) est la mesure de la similitude entre deux signaux. Afin de mieux appréhender cette notion, on procédera à l’estimation de la corrélation croisée entre un signal sonore échantillonné et un fragment de ce signal, en utilisant les outils appropriés fournis par MATLAB. Le signal sonore qui fera l’objet de cet exercice est celui d’un anneau tournant sur une table.

1- On Charge dans l’espace de travail l’enregistrement correspondant en tapant la commande load(‘Ring.mat’).  

```MATLAB
clear all
close all
clc
load('Ring.mat');
```
2- On Trace ce signal en fonction du temps.
```MATLAB
F=44100;
Ts =1/F;
t =0:Ts:(length(y)-1)*Ts ;
 plot(t,y);
%sound(y,F)
 ```
 3- A l'aide de deux droites en pointillés rouges,on repére le morceau du signal entre t=7s et t=8s (Commande : xline).
 ```MATLAB
 xline(7,'--r');
 xline(8,'--r');
 ```
 ![WhatsApp Image 2022-02-06 at 00 38 23](https://user-images.githubusercontent.com/53974876/152662617-a79e1c29-72bf-4071-85f8-d49ca8e0c859.jpeg)
 
 4-On récupére ce morceau dans une variable nommée « Fragment », puis on le trace en fonction du temps:

```MATLAB
 fragment=y(7*F:8*F);
 %sound(fragment,F);
 figure(2)
  plot(fragment)
```
![WhatsApp Image 2022-02-06 at 00 41 19](https://user-images.githubusercontent.com/53974876/152662677-d3d4bb52-70d3-4b4e-8589-72093b8eac80.jpeg)

5- ON Calcule puis on trace la corrélation croisée du signal complet et du fragment.
correlation=xcorr(y,fragment);
figure(3)
%Le plus grand pic se produit à la valeur de décalage lorsque les éléments de x et y correspondent exactement
plot(correlation);

![WhatsApp Image 2022-02-06 at 00 44 43](https://user-images.githubusercontent.com/53974876/152662745-bd2f55ba-c1c9-4db8-8dd8-7abd62ae0e37.jpeg)




6- Déduisez la valeur du décalage pour lequel la corrélation entre les deux signaux est maximal, puis utilisez ce décalage pour faire apparaitre le fragment dans le signal.
```MATLAB
  figure(4);
%find value and index of maximum value of cross-correlation amplitude
[m,d]=max(correlation);      
%shift index d, as length(y)=2*N-1; where N is the length of the signals
delay=d-max(length(y),length(fragment));   
%Plot signal s1
plot(y)                                     
hold on
plot([delay+1:length(fragment)+delay],fragment,'r');  
```

![WhatsApp Image 2022-02-06 at 00 46 29](https://user-images.githubusercontent.com/53974876/152662776-1178bfc1-d783-407e-a6fb-45022ca63bd6.jpeg)



#  _Mesure de similarité entre deux signaux en présence du bruit_



Dans cette partie, nous chercherons à évaluer le degré de dépendance de deux signaux en présence du bruit, en utilisant toujours cette notion de corrélation croisée.

1- On ajoute un bruit blanc gaussien au signal de départ et aussi au fragment, puis on les trace en fonction du temps
```MATLAB
YNOISE = awgn(y,30)+y;
fnoise=awgn(fragment,30)+fragment;
figure(5);
plot(t,[y YNOISE]);
xline(7,'--r');
 xline(8,'--r');
figure(6);
plot(fnoise);
```


- ### signal de départ bruité:

![c044cc7a-c7cf-42ef-b7de-b7afbdf875a9](https://user-images.githubusercontent.com/53974876/152662827-ef7c6632-0a66-431f-b508-20aee1635154.jpg)

- ### Fragment bruité:

![eec6eeb0-16b4-4b2e-800f-c96bf148dc5f](https://user-images.githubusercontent.com/53974876/152662856-d514a813-4e1c-42db-887a-63ffc2900b78.jpg)

2-On applique la fonction xcorr afin de calculer la corrélation croisée entre les deux signaux bruités, puis on évalue la capacité de cette mesure de détecter le fragment dans le signal en présence du bruit.Puis on trace toutes les figure:

```MATLAB
correlation1=xcorr(YNOISE,fnoise);
  figure(7)
 %Le plus grand pic se produit à la valeur de décalage lorsque les éléments de x et y correspondent exactement
  plot(correlation1);
  figure(8);
%find value and index of maximum value of cross-correlation amplitude
[m,d]=max(correlation1);
%shift index d, as length(YNOISE)=2*N-1; where N is the length of the signals
delay=d-max(length(YNOISE),length(fnoise));   
plot(YNOISE);
hold on,plot([delay+1:length(fnoise)+delay],fnoise,'r');
```
- ### Voici la corrélation:

![35646f88-6698-4efb-a3fb-d7e62bb93fdc](https://user-images.githubusercontent.com/53974876/152662905-5413e6ac-cbb0-46f3-922c-05f485f1ccec.jpg)

- ### Voici le signal détecté sur le signal de départ:

![6ca273e8-3ee8-4f1a-8a22-9d9b6bb43e54](https://user-images.githubusercontent.com/53974876/152662932-5723a107-939a-494d-8e3a-5725e91b8bc5.jpg)


On peut Conclure que Le résultat de xcorr peut être interprété comme une estimation de la corrélation entre deux séquences aléatoires ou comme la corrélation déterministe entre deux signaux déterministes.

FIN.

realisée par Lakhmiri Mohammed Elias


