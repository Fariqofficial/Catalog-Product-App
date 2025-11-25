## Features
- List product from API **fakestoreapi.com/products**
- List product cart with local storage use **Shared Preferences**
- Detail product
- Add to cart with local storage use **Shared Preferences**
- Remove multiple or single items use **Shared Preferences**
- Search product by name or description
- Support infinite scroll pagination

## Project Structure (Clean Architecture)
```bash
lib/
├── common/
│   ├── routes/
│   ├── utils/
├── core/
│   ├── error/
│   ├── network/
├── features/
│   └── product/
│       ├── data/
│       ├   ├── datasource/
│       ├   ├── mapper/
│       ├   ├── repositories_impl/
│       ├── domain/
│       ├   ├── entities/
│       ├   ├── repositories/
│       ├   ├── usecase/
│       └── presentation/
│       ├   ├── screen/
│       ├   ├── ├── cubit/
│       ├   ├── ├── widgets/
└── injection.dart
└── main.dart
```

## Installation Instructions
1. Clone this repository
```bash
git clone https://github.com/username/imperial-article.git
cd catalog_product_app
```
## IMPORTANT - Environment Setup
1. The project has a file named **dev.env**.
2. Rename the **dev.env** file to **.env**
3. After renaming the **dev.env** file to **.env**, run **flutter clean** & **flutter pub get**, then run the **flutter run** command.

## How To Run Project
```bash
flutter run
```

## Screenshot Apps
List products with infinite scroll pagination

<img width="329" height="719" alt="List Product Screen" src="https://github.com/user-attachments/assets/7d7f164e-aa59-435a-b0fe-2c15ae1cab6f" />


Search Product by name or description

<img width="329" height="719" alt="search products" src="https://github.com/user-attachments/assets/bcf69b39-5386-4bbf-a5c5-39f9672be7ed" />


Detail product

<img width="329" height="719" alt="detail products" src="https://github.com/user-attachments/assets/98dc91ca-78f1-4dc3-9a8b-ae885c5277ec" />


Add to cart feature

<img width="329" height="719" alt="Add To Cart Features" src="https://github.com/user-attachments/assets/06c4e9ee-c499-4305-9e7f-1d376804b7ab" />


List cart

<img width="329" height="719" alt="List Product Cart" src="https://github.com/user-attachments/assets/b8095459-1d00-4b92-8750-97400765041b" />


Delete multiple or single items

<img width="329" height="719" alt="List Product Cart" src="https://github.com/user-attachments/assets/d4972afa-b046-4795-88fe-796ca3e6bf25" />

<img width="329" height="719" alt="Delete Multiple Items" src="https://github.com/user-attachments/assets/35d01c78-b68d-458d-9e1c-2df888de960e" />

<img width="329" height="719" alt="success delete" src="https://github.com/user-attachments/assets/de418b40-744e-49b1-8523-9bd8e915a077" />








   
