namespace :data do
  task :new_problems => :environment do
    [
      "All American workers should receive paid vacations.",
      "All American workers should receive paid family leave.",
      "All American workers should receive paid sick leave.",
      "All American workers should receive paid sabbaticals.",
      "All American workers should be protected by free legal assistance for age discrimination or unjust firing",
      "All American workers should be protected by mandatory severance pay",
      "All American workers should be protected by universal unemployment benefits",
      "All American workers should be protected by a new GI bill for vocational education",
      "Employers must pay their share of FICA taxes for all employees",
      "Public defenders must be fully funded in all cities",
      "All forms of ‘offender-funded justice’ must be terminated. No one will be made to pay for their own parole, or pre-sentencing report, or for any aspect of incarceration.",
      "All college students should receive free tuition for community colleges or vocational schools",
      "All college students should receive forgiveness of existing student loans after ten years of repayments",
      "All college students should receive inclusion of student loans in bankruptcy",
      "All debtors would benefit by reinstatement of usury laws – 10 per cent interest is enough",
      "All debtors would benefit by interest-free federal loans to pay off medical debts",
      "All medical patients would be protected by regulations on emergency room charges",
      "All medical patients would be protected by price controls on drugs with no substitutes",
      "All medical patients would be protected by health courts to challenge unconscionable bills",
      "Hospitals can no longer use their “chargemaster” rates to bill the uninsured.",
      "Doctors called in for emergencies can charge 200% of Medicare (not 800% of Medicare, as they often do today).",
      "In medical emergencies, the charges to an uninsured or ‘out of-network’ patient must not exceed 150% of the lowest basic charge in the Medicare fee schedule.",
      "End the War on Drugs",
      "Redirect 20% of Pentagon spending to social programs",
      "Expand Section 8 rent subsidies",
      "Establish A National Fee Schedule for Emergency Procedures",
      "Remove all bans on drug imports",
      "Eliminate FDA approval of new generic medications",
      "Establish Health Courts, where patients can challenge medical bills",
      "Part-time and temporary employees will get $15 an hour minimum, paid sick leave and paid holidays",
      "No-interest loans must be available for emergencies (such as utility shutoffs, medical crises, legal expenses)"
    ].each do |problem_name|
      Problem.create(name: problem_name)
    end
  end
end