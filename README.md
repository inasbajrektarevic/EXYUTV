EXYUTV

Desktop app:

Uloga: Admin, username:site.admin Password:Test1234

Mobile app:

Uloga: User, username:client1 Password:Test1234

Uloga: User, username:client2 Password:Test1234

Prilikom pokretanja mobilne aplikacije, OBAVEZNO pokrenuti komandu .\setup_env.bat , kako bi se uspostavila ispravna konekcija sa Stripe sistemom plaćanja i kako bi se .env fajl popunio vrijednostima. Tu se OBAVEZNO moraju unijeti oba stripe ključa koja su navedena ispod (ili Vaši lični stripe ključevi).

Stripe:

STRIPE_SECRET = sk_test_51QviG8R9Lklfo9BXspDysklL8hUaQuBLoKEQZXnQNGBKl66GubzPlpKrIIEZRiVKuYpNEBA9Va82emIILD2mZmNc00uT9sP798

STRIPE_PUBLISHABLE_KEY = pk_test_51QviG8R9Lklfo9BXpB2zx5xdWAf25TLzII7xyaLcJOTdk5Pk3LHoAUwPQs2RO7eiZ0iu1XhVAFblMptvHFr38Kzr00aLOzBlOW

Podaci za Stripe plaćanje:

Card number: 4242 4242 4242 4242

Date: Bilo koji datum u budućnosti

CVC: Bilo koje 3 cifre

ZIP Code: Bilo kojih 5 cifara
