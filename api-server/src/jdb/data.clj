(ns jdb.data 
  #_{:clj-kondo/ignore [:refer-all]}
  (:require [clojure.java.io :as io]
            [cheshire.core :refer :all]))

(def ledger-json-file "/tmp/ledger.json")
(def budget-json-file "/tmp/budget.json")
(def categories-json-file "/tmp/categories.json")

(defn all-data
  []
  {:categories (read-categories)
   :budget (read-budget)
   :ledger (read-ledger)})

(defn read-ledger
  []
  (parse-stream (io/reader ledger-json-file)))

(defn read-budget
  []
  (parse-stream (io/reader budget-json-file)))

(defn read-categories
  []
  (parse-stream (io/reader categories-json-file)))

(defn write-ledger
  [new-ledger]
  (let [existing-ledger (parse-stream (io/reader ledger-json-file))
        merged-ledger (conj (vec existing-ledger) new-ledger)]
    (if (generate-stream merged-ledger (io/writer ledger-json-file))
      true
      false)))

(defn write-budget
  [budget-data]
  (if (generate-stream budget-data (io/writer budget-json-file))
    true
    false))

(defn write-categories
  [categories-data]
  (if (generate-stream categories-data (io/writer categories-json-file))
    true
    false))

;;
;; Dummy data
;;
#_{:clj-kondo/ignore [:clojure-lsp/unused-public-var]}
(defn dummy-ledger
  []
  [{:year 2021
    :month 12
    :day 1
    :bank "Checking"
    :creditor ""
    :debtor "Sunflower Pediatrics"
    :description "Flynn's doctor appointment"
    :category :medical
    :expense 117.38
    :income 0.0}
   {:year 2021
    :month 12
    :day 1
    :bank "Checking"
    :creditor "Jill"
    :debtor ""
    :description "Flynn's doctor appointment"
    :category :medical
    :expense 58.69
    :income 0.0}])

#_{:clj-kondo/ignore [:clojure-lsp/unused-public-var]}
(defn dummy-budget
  []
  {:income 12500.0
   :groceries 750.0
   :misc 162.0
   :dining 75.0
   :haircutsClothing 25.0
   :gifts 30.0
   :homeRepairMaintenance 45.0
   :internetTechnology 127.0
   :entertainment 25.0
   :medical 150.0
   :school 40.0
   :autoFuelParkingMaintenance 78.0
   :utilities 126.0
   :selfEmploymentTax 775.0
   :insurance 81.0
   :cellPhones 84.0
   :bjj 188.0
   :piano 50.0
   :mortgage 1312.0
   :carRegistration 15.0
   :taxPrep 86.0})

#_{:clj-kondo/ignore [:clojure-lsp/unused-public-var]}
(defn dummy-categories
  []
  {
   :groceries "Groceries"
   :misc "Misc"
   :dining "Misc"
   :haircutsClothing "Haircuts & Clothing"
   :gifts "Gifts"
   :homeRepairMaintenance "Home Repair & Maintenance"
   :internetTechnology "Internet & Technology"
   :entertainment "Entertainment"
   :medical "Medical"
   :school "School"
   :autoFuelParkingMaintenance "Auto Fuel, Parking & Maintenance"
   :utilities "Utilities"
   :selfEmploymentTax "Self Employment Tax"
   :insurance "Insurance"
   :cellPhones "Cell Phones"
   :bjj "BJJ"
   :piano "Piano"
   :mortgage "Mortgage"
   :carRegistration "Car Registration"
   :taxPrep "Tax Prep"
  })
