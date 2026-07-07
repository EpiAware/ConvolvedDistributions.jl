# The abstract-family interface contract, verified with the shipped
# TestUtils verifiers (the same entry points a downstream member uses).

@testitem "AbstractCombinedDistribution contract and membership" begin
    using Distributions
    using ConvolvedDistributions.TestUtils: test_abstract_membership,
                                            test_combined_interface

    test_abstract_membership()

    test_combined_interface(
        convolved(Gamma(2.0, 1.0), LogNormal(0.5, 0.4));
        x = 3.0)
    test_combined_interface(
        convolved(Normal(0.0, 1.0), Normal(1.0, 2.0));
        name = "Convolved (analytic)", x = 1.0)
    test_combined_interface(
        difference(Gamma(3.0, 1.0), LogNormal(0.5, 0.4)); x = 0.5)
    test_combined_interface(
        difference(Normal(1.0, 1.0), Normal(0.0, 1.0));
        name = "Difference (analytic)", x = 0.5)
end
