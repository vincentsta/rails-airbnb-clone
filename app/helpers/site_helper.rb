module SiteHelper
  def results_text(nb_jobs)
    perso_txt = "Trop cool, l'embarras du choix !" if nb_jobs > 50
    perso_txt = "Pas de chance, il va falloir élargir ta recherche" if nb_jobs < 6
    return "#{nb_jobs} résultats pour ta recherche. #{perso_txt}"
  end

  def date_string(date)
    date.strftime("%d/%m/%Y")
  end
end
