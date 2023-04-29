import pandas as pd
from datacleaning import generate_psf_ppi_df, generate_forecast_df, generate_overall_prediction, calc_mean_delta_PPI

# testing generate_psf_ppi_df function (absolute)
delta_abs = False   # test mean_delta_PPI
mean_delta_PPI = calc_mean_delta_PPI(delta_abs)
print(mean_delta_PPI)

sheet_name = "CAMELOT BY-THE-WATER"
prop_df = pd.read_excel("Raw Data/" + "condominium_edgeprop.xlsx", sheet_name=sheet_name)
ppi_df = pd.read_csv("Raw Data/" + "private-residential-property-price-index-base-quarter-2009-q1-100-quarterly.csv")

psf_ppi_df = generate_psf_ppi_df(prop_df, ppi_df, delta_abs=delta_abs)
print("------------------- Absolute delta -------------------")
print(psf_ppi_df.tail())

# testing with URA data (edgeprop=False)
sheet_name = "CAMELOT BY-THE-WATER"
prop_df = pd.read_excel("Raw Data/" + "output.xlsx", sheet_name=sheet_name)
ppi_df = pd.read_csv("Raw Data/" + "private-residential-property-price-index-base-quarter-2009-q1-100-quarterly.csv")

psf_ppi_df = generate_psf_ppi_df(prop_df, ppi_df, delta_abs=delta_abs, edgeprop=False)
print("------------------- Absolute delta with URA data -------------------")
print(psf_ppi_df.tail())

# testing generate_psf_ppi_df function (percentage)
delta_abs = True
mean_delta_PPI = calc_mean_delta_PPI(delta_abs)
print("------------------- Percentage delta -------------------")
print(mean_delta_PPI)

sheet_name = "CAMELOT BY-THE-WATER"
prop_df = pd.read_excel("Raw Data/" + "condominium_edgeprop.xlsx")
ppi_df = pd.read_csv("Raw Data/" + "private-residential-property-price-index-base-quarter-2009-q1-100-quarterly.csv")

psf_ppi_df = generate_psf_ppi_df(prop_df, ppi_df, delta_abs=delta_abs)
print(psf_ppi_df.tail())

# testing generate_forecast_df function
print("------------------- Forecasting DF -------------------")
forecast_df = generate_forecast_df(psf_ppi_df, X_cols=["delta_PPI", "No. of Transactions in previous quarter"], forecast_X=[calc_mean_delta_PPI(False), 1], delta_abs=True)
print(forecast_df)
