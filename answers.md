# World Database Practice - Answers

## Aggregation & Grouping

### Q8 - Top 3 Most Spoken Languages
| Language | Total Speakers |
|----------|---------------|
| Chinese | 1,191,843,539 |
| Hindi | 405,633,070 |
| Spanish | 355,029,462 |

### Q9 - Highest GNP Per Capita by Continent
| Continent | Country | GNP/Capita |
|-----------|---------|-----------|
| Asia | Brunei | $35,686 |
| Europe | Luxembourg | $37,459 |
| North America | Bermuda | $35,815 |
| Africa | Reunion | $11,856 |
| Oceania | Australia | $18,595 |
| South America | Argentina | $9,188 |

### Q10 - Biggest GNP Gap by Region
North America has the biggest gap: $8,508,372M between the US ($8,510,700M) and the poorest ($2,328M).

---

## Subqueries & Correlated Subqueries

### Q11 - Official Languages All Under 50%
59 countries. Some notable ones: India, Pakistan, Indonesia, South Africa, Switzerland, Hong Kong, Haiti, Zimbabwe.

### Q12 - Biggest City That Isn't the Capital
| City | Country | Population |
|------|---------|-----------|
| Mumbai | India | 10,500,000 |
| Sao Paulo | Brazil | 9,968,485 |
| Shanghai | China | 9,696,300 |
| Karachi | Pakistan | 9,269,265 |
| Istanbul | Turkey | 8,787,958 |
| New York | United States | 8,008,278 |

### Q13 - Countries With No Official Language
49 countries including Nigeria, Jamaica, Ethiopia, Ghana, Papua New Guinea, Cameroon.

---

## Joins & Multi-table

### Q14 - Capitals Smaller Than 3+ Other Cities
| Country | Capital | Bigger Cities |
|---------|---------|--------------|
| India | New Delhi | 85 |
| United States | Washington | 20 |
| Nigeria | Abuja | 13 |
| Canada | Ottawa | 12 |
| Pakistan | Islamabad | 9 |
| Australia | Canberra | 5 |
| Brazil | Brasilia | 5 |
| Switzerland | Bern | 3 |

### Q15 - Countries With a Unique Language
Many smaller countries have languages spoken nowhere else in the DB. Examples: Bhutan (Dzongkha), Cambodia (Khmer), Japan (Japanese), Mongolia (Mongolian).

### Q16 - Healthy But Poor (High Life Expectancy, Low GNP for Their Continent)
52 countries total. Highlights: Cuba (LE 76.2, low GNP), China (LE 71.4), Costa Rica (LE 75.8), Vietnam (LE 69.3).

---

## Advanced / Window Functions

### Q17 - Top 3 Cities Per Country
Used ROW_NUMBER() window function to rank cities within each country by population. For example: India -> Mumbai, Delhi, Calcutta. US -> New York, Los Angeles, Chicago.

### Q18 - Continents That Punch Above Their Weight
| Continent | Pop % | GNP % | Ratio |
|-----------|-------|-------|-------|
| North America | 8.0% | 33.0% | 4.15 |
| Oceania | 0.5% | 1.4% | 2.86 |
| Europe | 12.0% | 32.4% | 2.69 |
| South America | 5.7% | 5.2% | 0.91 |
| Asia | 61.0% | 26.1% | 0.43 |
| Africa | 12.9% | 2.0% | 0.15 |

North America produces 4x more GNP than its share of population. Africa is the opposite.

### Q19 - Population Twins on Different Continents
| Country 1 | Country 2 | Diff |
|-----------|-----------|------|
| Azerbaijan (7.73M) | Rwanda (7.73M) | 0.0% |
| Jordan (5.08M) | Nicaragua (5.07M) | 0.2% |
| New Zealand (3.86M) | Puerto Rico (3.87M) | 0.2% |
| Cuba (11.2M) | Cambodia (11.2M) | 0.3% |
| Australia (18.9M) | Sri Lanka (18.8M) | 0.3% |
