package validator

import "testing"

func TestIsStringNice(t *testing.T) {
	actual := IsStringNice("aaa")
	expected := true

	if actual != expected {
		t.Errorf("IsStringNice test expected [%t], actual [%t]", expected, actual)
	}

	actual = IsStringNice("ugknbfddgicrmopn")
	expected = true

	if actual != expected {
		t.Errorf("IsStringNice test expected [%t], actual [%t]", expected, actual)
	}

	actual = IsStringNice("jchzalrnumimnmhp")
	expected = false

	if actual != expected {
		t.Errorf("IsStringNice test expected [%t], actual [%t]", expected, actual)
	}

	actual = IsStringNice("haegwjzuvuyypxyu")
	expected = false

	if actual != expected {
		t.Errorf("IsStringNice test expected [%t], actual [%t]", expected, actual)
	}

	actual = IsStringNice("dvszwmarrgswjxmb")
	expected = false

	if actual != expected {
		t.Errorf("IsStringNice test expected [%t], actual [%t]", expected, actual)
	}
}

func BenchmarkIsStringNice(b *testing.B) {
	for n := 0; n < b.N; n++ {
		IsStringNice("dvszwmarrgswjxmb")
	}
}
