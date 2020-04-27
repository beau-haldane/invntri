## Installation Instructions

1. Follow these instructions to [download and install](https://www.ruby-lang.org/en/documentation/installation/) Ruby on your computer. 

2. Download and unzip the project files onto your computer. 

3. Now, in your terminal navigate to the folder you want to install the app  by running:

```
cd ~/ *path to folder you want to install app*
```

4. Clone the files from this repository by copying the following command line:

```
git clone https://github.com/beau-haldane/invntri.git
```

5. From here, navigate to the src folder of the cloned repository:

```
cd invntri/src
```

6. Run the shell script to install all gems and run INVNTRI:

```
./run-app.sh
```

**Enjoy!**

## Dependencies

- Ruby must be installed on your computer (follow step 1 of installation guide above)
- A number of gems used in the app are required in order for it to run
    - If you've installed the app using step 6 above, you have completed gem installation
    - Otherwise, navigate to the src directory of INVNTRI and run
        ```
        bundle install
        ```

## System/Hardware Requirements

 - INVNTRI will run on any computer that has Ruby installed.

## Features	

### Add Inventory Item
  - Asks relevant questions to user about the item, creates a hash containing item information, pushes hash into main array containing all inventory items

### Edit Inventory Item
  * Takes a name or SKU as search input from the user, returns all inventory items whose name or SKU fields contain the search term, allows user to select which item they'd like to edit, then allows them to edit any of the details contained in that item's hash

### Remove Inventory Item
  * Takes a name or SKU as search input from the user, returns all inventory items whose name or SKU fields contain the search term, allows user to select which item they'd like to remove, and removes it with confirmation from the user.

### View Inventory
  * Entire Inventory
    * Returns a neatly formatted list of all inventory items
  * By Category:
    * Returns a list of all inventory items contained within the chosen category
  * By Sub_Category
    * Returns a list of all inventory items contained within the chosen sub-category

### Search Inventory
  * Takes a name or SKU as search input from the user, returns all inventory items whose name or SKU fields contain the search term

### Add Category/Sub-Category
  * Add Category
    * User inputs name of new category, and it is created
  * Add Sub-Category
    * User inputs name of new sub-category, and they can either assign it to an existing category, or make a new one. These are then created