  campaign_acceptance = AcceptedCmp1 + AcceptedCmp2 + AcceptedCmp3 + AcceptedCmp4 + AcceptedCmp5;

  Childhome = 1*((Kidhome=1) | (Teenhome=1));

  Mnt = IMP_MntScenario +  MntMiniatures + MntCard_Games + MntMagazines + MntPainting_Material;

    IMP_MntScenario = IMP_MntScenario/Mnt;

    MntMiniatures = MntMiniatures/Mnt;

    MntCard_Games = MntCard_Games/Mnt;

    MntMagazines = MntMagazines/Mnt;

    MntPainting_Material = MntPainting_Material/Mnt;

    IMP_MntBrandA__Material = IMP_MntBrandA__Material/Mnt;

  Frq = NumCatalogPurchases  +  NumStorePurchases + NumWebPurchases;

    NumCatalogPurchases = NumCatalogPurchases/Frq;

    NumStorePurchases = NumStorePurchases/Frq;

    NumWebPurchases = NumWebPurchases/Frq;

    NumDealsPurchases = NumDealsPurchases/Frq;

  average_purchase = Mnt / Frq;

  age = year(today())-Year_Birth;

  loyalty = 12*(year(today()) - year(Dt_Customer)) + month(today())-month(Dt_Customer);
